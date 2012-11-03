# encoding: utf-8

class PdfdocUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes
  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog

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

  version :thumb do
     process :resize_to_fit => [300, 300]
     process :convert => 'jpeg'
     process :biggest_square
     
     def full_filename (for_file = model.logo.file)
       super.chomp(File.extname(super)) + '.jpg'
     end     
  end
  
  def set_content_type(*args)
      self.file.instance_variable_set(:@content_type, "image/jpeg")
  end
  
  # Autoorients image according to exif
    def auto_orient
      manipulate! {|img| img.auto_orient! || img }
    end

    # Crops the biggest possible square from the image
    def biggest_square
      manipulate! do |img|
        if img.rows != img.columns
          max = img.rows > img.columns ? img.columns : img.rows
          img.crop!(0,0,max,max,true)
        else
          img
        end
      end
    end

    # Create rounded corners for the image
    def rounded_corners
      radius = 10
      manipulate! do |img|
        #create a masq of same size
        masq = Magick::Image.new(img.columns, img.rows)
        d = Magick::Draw.new
        d.roundrectangle(0, 0, img.columns - 1, img.rows - 1, radius, radius)
        d.draw(masq)
        img.composite(masq, 0, 0, Magick::LightenCompositeOp)
      end
    end

    # Removes all meta information
    def strip
      manipulate! {|img| img.strip! }
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
