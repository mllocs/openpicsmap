require "yaml"

class Pic < ActiveRecord::Base

  attr_accessible :address, :description, :latitude, :longitude, :taken_at, :title, :image
  # geocoded_by :address

  validates :title, :presence => true
  validates :image, :presence => true

  mount_uploader :image, ImageUploader

  # after_validation :geocode, :if => :address_changed?
  before_save :parse_exif, :if => :image_changed?
  # after_save :optimize_jpeg, :if => :image_changed? 
  before_destroy :destroy_image

  def as_json(options = { })
    hash = super(options) || {}
    hash.merge!({
      "image_url" => self.image_url,
      "image_thumb_url" => self.image_url(:thumb),
      "edit_pic_path" => (self.new_record? ? nil : Rails.application.routes.url_helpers.edit_pic_path(self)),
      "show_pic_path" => (self.new_record? ? nil : Rails.application.routes.url_helpers.pic_path(self))
    })
    hash
  end

  def get_lat
    self.latitude ? self.latitude.round(3) : "undefined"
  end

  def get_lon
    self.longitude ? self.longitude.round(3) : "undefined"
  end

  def get_desc
    (self.description.empty? or self.description.nil?) ? "No description." : self.description
  end

  def next_pic
    self.class.where("id > ?", id).order("id desc").first
  end

  def prev_pic
    self.class.where("id < ?", id).order("id desc").first
  end

  # def print_metadata
  #   md = ""
  #   hash = YAML::load self.metadata
  #   hash.each do |k,v|
  #     md += "#{k}: #{v.to_s}, "
  #   end
  #   md.slice(0..-3) # remove last ", "
  # end

  def destroy_image
    self.remove_image!
  end

  # def optimize_jpeg
  #   unless Rails.env == "test"
  #     image_dir = File.dirname File.dirname(self.image_path)
  #     %x[jpegoptim `find #{image_dir} -name *.JPG`]
  #   end
  # end

  def parse_exif
    exif = EXIFR::JPEG.new(image.path)
    self.taken_at = exif.date_time

    self.metadata = {
      width: exif.width,
      height: exif.height,
      model: exif.model,
      exposure_time: exif.exposure_time.to_s,
      f_number: exif.f_number.to_f
    }
  end

end
