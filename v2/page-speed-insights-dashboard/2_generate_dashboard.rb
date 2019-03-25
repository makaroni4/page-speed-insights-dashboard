require "erb"
require "ostruct"
require "json"
require "byebug"
require "json"

DATA_FILE = "data.json"

# https://stackoverflow.com/questions/8954706/render-an-erb-template-with-values-from-a-hash
class ErbalT < OpenStruct
  def render(template)
    ERB.new(template).result(binding)
  end
end

File.open("public/index.html", "w") do |f|
  template = File.read("index.html.erb")

  et = ErbalT.new({
    psi_data: JSON.parse(File.read(DATA_FILE))
  })

  f.puts et.render(template)
end
