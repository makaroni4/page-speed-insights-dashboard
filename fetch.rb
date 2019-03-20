require "net/http"
require "uri"
require "pp"
require "json"
require "byebug"
require "yaml"

BASE_URL = "https://www.googleapis.com/pagespeedonline/v5/runPagespeed"
API_KEY = File.read(".psi_api_key")
DATA_FILE = "psi_dashboard.yml"
PSI_DEVICE_TYPES = %w(mobile desktop)

def persist(url, device_type, timestamp, report_data)
  historic_data = File.exist?(DATA_FILE) ? YAML.load(File.read(DATA_FILE)) : {}

  historic_data[url] ||= {}
  historic_data[url][device_type] ||= {}
  historic_data[url][device_type][timestamp] = report_data

  File.open(DATA_FILE, "w") do |file|
    file.write(historic_data.to_yaml)
  end
end

def fetch(device_type, url)
  params = {
    url: url,
    strategy: device_type,
    category: "performance",
    locale: "en",
    key: API_KEY
  }

  uri = URI.parse(BASE_URL)
  uri.query = URI.encode_www_form(params)

  raw_data = JSON.parse(Net::HTTP.get(uri))

  {
    speed_index: raw_data["lighthouseResult"]["audits"]["speed-index"]["score"],
    first_contentful_paint: raw_data["lighthouseResult"]["audits"]["first-contentful-paint"]["displayValue"],
    time_to_interactive: raw_data["lighthouseResult"]["audits"]["interactive"]["displayValue"],
    first_meaningful_paint: raw_data["lighthouseResult"]["audits"]["first-meaningful-paint"]["displayValue"],
    first_cpu_idle: raw_data["lighthouseResult"]["audits"]["first-cpu-idle"]["displayValue"]
  }
end

def download_report(url)
  timestamp = Time.now

  PSI_DEVICE_TYPES.each do |device_type|
    report_data = fetch(device_type, url)

    persist(url, device_type, timestamp, report_data)
  end
end

urls = [
  "https://www.blinkist.com/nc/books-in-brief",
  "https://www.blinkist.com",
  "https://www.blinkist.com/magazine/posts/simplify-amanda-siebert-cannabis"
]

urls.each do |url|
  download_report(url)
end
