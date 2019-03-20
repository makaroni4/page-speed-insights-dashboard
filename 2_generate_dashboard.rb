require "erb"
require "ostruct"
require "json"
require "byebug"
require "yaml"

DATA_FILE = "historic_data.yml"

# https://stackoverflow.com/questions/8954706/render-an-erb-template-with-values-from-a-hash
class ErbalT < OpenStruct
  def render(template)
    ERB.new(template).result(binding)
  end
end

File.open("dashboard/dashboard.html", "w") do |f|
  template = File.read("dashboard.html.erb")

  et = ErbalT.new({
    psi_data: YAML.load(File.read(DATA_FILE))
  })

  f.puts et.render(template)
end

system `open dashboard/dashboard.html`
