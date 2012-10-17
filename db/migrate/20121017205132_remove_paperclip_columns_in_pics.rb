class RemovePaperclipColumnsInPics < ActiveRecord::Migration
  def self.up
    remove_column :pics, :image_file_name
    remove_column :pics, :image_content_type
    remove_column :pics, :image_file_size
    remove_column :pics, :image_updated_at
  end

  def self.down
    puts "Should add paperclip columns"
  end
end
