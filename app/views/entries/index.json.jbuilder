json.array!(@entries) do |entry|
  json.extract! entry, :id, :title, :content, :date
  json.url entry_url(entry)
end
