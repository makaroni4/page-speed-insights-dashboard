require "net/http"
require "uri"
require "pp"
require "json"
require "byebug"
require "json"

BASE_URL = "https://www.googleapis.com/pagespeedonline/v5/runPagespeed"
DATA_FILE = "public/data/data.json"
PSI_DEVICE_TYPES = %w(mobile desktop)
URLS_FILE = "urls.json"

def persist(url, device_type, report_data)
  historic_data = File.exist?(DATA_FILE) ? JSON.parse(File.read(DATA_FILE)) : {}

  historic_data[url] ||= {}
  historic_data[url][device_type] ||= {}
  historic_data[url][device_type][Time.now] = report_data

  File.open(DATA_FILE, "w") do |file|
    file.write(historic_data.to_json)
  end
end

def extract_metric(raw_data, *json_keys)
  raw_data.dig("lighthouseResult", "audits", *json_keys)
end

def fetch(device_type, url)
  params = {
    url: url,
    strategy: device_type,
    category: "performance",
    locale: "en"
  }

  uri = URI.parse(BASE_URL)
  uri.query = URI.encode_www_form(params)

  response = Net::HTTP.get(uri)

  raw_data = JSON.parse(response)

  return raw_data if raw_data.has_key?("error")

  {
    speed_index: (extract_metric(raw_data, "speed-index", "score") * 100).to_i,
    first_contentful_paint: extract_metric(raw_data, "first-contentful-paint", "displayValue").to_f,
    time_to_interactive: extract_metric(raw_data, "interactive", "displayValue").to_f,
    first_meaningful_paint: extract_metric(raw_data, "first-meaningful-paint", "displayValue").to_f,
    first_cpu_idle: extract_metric(raw_data, "first-cpu-idle", "displayValue").to_f
  }
end

def download_report(url)
  PSI_DEVICE_TYPES.each do |device_type|
    report_data = fetch(device_type, url)

    if report_data.has_key?("error")
      puts "--> Error while fetching #{device_type} report for #{url}"
      puts "--> #{report_data}"
      puts

      next
    else
      puts "--> Saving #{device_type} report for #{url}"
    end

    persist(url, device_type, report_data)
  end
end

urls = JSON.parse(File.read(URLS_FILE))
urls.each do |url|
  download_report(url)
end
