class Metadata < Paperclip::Processor

  def initialize(file, options = {}, attachment = nil)
    @file           = file
    @instance       = attachment.instance
  end

  def make

    exif = EXIFR::JPEG.new(@file.path)
    @instance.taken_at = exif.date_time

    # metadata
    metadata_fields = exif.methods.select{|m| m.class == String and exif.send(m) != nil}
    @instance.metadata = {}
    metadata_fields.each do |m|
      @instance.metadata.merge!({ m => exif.send(m).to_s})
    end

    # @instance.metadata = {
    #   :model => exif.model,
    #   :exposure_time => exif.exposure_time.to_s,
    #   :f_number => exif.f_number.to_f
    # }

    @file

  end

end