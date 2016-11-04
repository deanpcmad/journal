# Importer for DayOne
# Export content and export the contents into a dayone folder inside this app

file = File.open("dayone/Journal.json").read

data = JSON.parse(file)
entries = data["entries"]

puts "Found #{entries.count} entries"

entries.each do |e|
  content = e["text"]
  content.gsub!("\n\n![](", "")
  content.gsub!("![](", "")
  content.gsub!(/dayone-moment:(.*)/, "")

  @entry = Entry.create date: e["creationDate"], content: content

  puts "  - Created Entry ##{@entry.id}"

  if e["photos"]
    e["photos"].each do |p|

      photo = File.open("dayone/photos/#{p["md5"]}.jpeg")

      @entry.attachments.create file: photo

      puts "    - Created Attachment"
    end
  end
end
