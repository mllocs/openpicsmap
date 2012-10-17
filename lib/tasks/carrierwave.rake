namespace :carrierwave do

  desc "Migrates from paperclip to carrierwave"
  task :migrate_table => :environment do
    # FileUtils.mkdir_p Rails.root.join('public', 'uploads')

    Pic.all.each do |pic|
      # filepath = Rails.root.join('public', 'system', 'images', pic.id.to_s, 'original', pic.image_file_name)
      # pic.image = File.open(filepath) if File.exists?(filepath)
      puts "updating #{pic.id}"
      pic.image = pic.image_file_name
      pic.save!
    end
  end

  desc "Migrates from paperclip to carrierwave"
  task :migrate_files => :environment do

    FileUtils.mkdir_p Rails.root.join('public', 'uploads', 'pic', 'image')

    Pic.all.each do |p|
      pic_folder = Rails.root.join('public', 'uploads', 'pic', 'image', p.id.to_s)
      unless Dir.exists?(pic_folder)
        puts "migrating #{p.id}"
        FileUtils.mkdir(pic_folder) 
        filename = p.image_file_name
        FileUtils.cp p.image.path(:original), carrierwave_filepath(p.id, filename, nil)
        FileUtils.cp p.image.path(:medium), carrierwave_filepath(p.id, filename, "medium")
        FileUtils.cp p.image.path(:thumb), carrierwave_filepath(p.id, filename, "thumb")
      end
    end

  end

  def carrierwave_filepath(id, filename, version)
    filename = "#{version}_#{filename}" if version
    "public/uploads/pic/image/#{id}/#{filename}"
  end

end
