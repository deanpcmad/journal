# encoding: utf-8

class AttachmentUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    "#{model.class.to_s.underscore}/#{model.id}"
  end

  # returns true if image file
  def image?(new_file)
    self.file.content_type.include? 'image'
  end

  version :thumb, :if => :image? do
    process :resize_and_pad => [150, 150]
  end

end
