atom_feed do |feed|
  feed.title "Open Pics Map"
  feed.updated @pics.maximum(:updated_at)
  @pics.each do |pic|
    feed.entry pic do |entry|
      entry.title pic.title
      entry.content ("<p>#{pic.full_description}</p>" + image_tag(pic.image.url(:medium))), type: 'html'
      entry.updated pic.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ")
      entry.author do |author|
        author.name 'admin'
      end
    end
  end
end
