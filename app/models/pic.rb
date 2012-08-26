require "yaml"

class Pic < ActiveRecord::Base
  attr_accessible :address, :description, :latitude, :longitude, :taken_at, :title, :image
  #geocoded_by :address

  has_attached_file :image, 
                    :styles => { :medium => "300x300>", :thumb => "100x100>" }, 
                    :processors => [:thumbnail, :metadata] # /lib/paperclip_processors/metadata.rb

  validates :image, 
            :attachment_presence => true, 
            :attachment_content_type => { :content_type => ['image/jpeg', 'image/jpg'] }
            
  validates :title, :presence => true

  #after_validation :geocode#, :if => :address_changed?
  before_destroy :destroy_image

  def as_json(options = { })
    hash = super(options) || {}
    hash.merge!({
      "image_url" => self.image.url,
      "image_thumb_url" => self.image.url(:thumb),
      "edit_pic_path" => (self.new_record? ? nil : Rails.application.routes.url_helpers.edit_pic_path(self))
    })
    hash
  end

  def get_lat
    self.latitude ? self.latitude.round(3) : "undefined"
  end

  def get_lon
    self.longitude ? self.longitude.round(3) : "undefined"
  end

  def print_metadata
    md = ""
    hash = YAML::load self.metadata
    hash.each do |k,v|
      md += "#{k}: #{v.to_s}, "
    end
    md.slice(0..-3) # remove last ", "
  end

  def destroy_image
    self.image.destroy
  end
end
