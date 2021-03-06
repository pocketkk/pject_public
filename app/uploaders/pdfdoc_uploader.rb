# encoding: utf-8
require 'carrierwave/processing/mime_types'

class PdfdocUploader < CarrierWave::Uploader::Base
  include ImageManipulators
  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes
  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  if Rails.env.test?
    storage :file
  else
    storage :fog
  end
  process :set_content_type

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  #def set_content_type(*args)
  #    content_type = file.content_type == 'application/octet-stream' || file.content_type.blank? ? MIME::Types.type_for(original_filename).first.to_s : file.content_type

  #    self.file.instance_variable_set(:@content_type, content_type)
  # end

  version :thumb_safari do
     process :resize_to_fit => [200, 200]
     process :convert => 'jpg'
     process :paper_shape
     def full_filename (for_file = model.logo.file)
        super.chomp(File.extname(super)) + '.jpg'
      end
   end

  version :thumb do
     process :resize_to_fit => [200, 200]
     process :convert => 'jpg'
     process :paper_shape
     process :convert => 'jpg'

     def full_filename (for_file = model.logo.file)
       super.chomp(File.extname(super)) + '.jpg'
     end
  end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png pdf)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
