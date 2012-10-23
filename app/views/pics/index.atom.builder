atom_feed do |feed|
  feed.title "Open Pics Map"
  feed.updated @pics.maximum(:updated_at)
  @pics.each do |pic|
    feed.entry pic, published: pic.updated_at do |entry|
      entry.title pic.title
      entry.content pic.full_description
      entry.link href: pic.image.url, rel:"enclosure", type:"image/jpeg" 
      entry.author do |author|
        author.name 'admin'
      end
    end
  end
end

# .strftime("%Y-%m-%dT%H:%M:%SZ")