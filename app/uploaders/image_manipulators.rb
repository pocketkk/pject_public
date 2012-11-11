module ImageManipulators

  # creates an image with a 3x4 aspect ratio
	def paper_shape
	   manipulate! do |img|
	     if img.rows*4 != img.columns*3
	       width=img.columns
	       height=img.columns/3*4
	       img.crop!(0,0,width,height,true)
	     else
	       img
	     end
	   end
	 end

   # Autoorients image according to exif
     def auto_orient
       manipulate! {|img| img.auto_orient! || img }
     end

     # Crops the biggest possible square from the image
     def biggest_square
       manipulate!(:format => 'jpg') do |img|
         if img.rows != img.columns
           max = img.rows > img.columns ? img.columns : img.rows
           img.crop!(0,0,max,max,true)
         else
           img
         end
       end
     end

     def paper_shape
       manipulate! do |img|
         if img.rows*4 != img.columns*3
           width=img.columns
           height=img.columns/3*4
           img.crop!(0,0,width,height,true)
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
     
     # Rotates the image based on the EXIF Orientation
         def fix_exif_rotation
           manipulate! do |img|
             img.auto_orient!
             img = yield(img) if block_given?
             img
           end
         end

         # Strips out all embedded information from the image
         def strip
           manipulate! do |img|
             img.strip!
             img = yield(img) if block_given?
             img
           end
         end
         
         def colorspace(cs)
             manipulate! do |img|
               case cs
               when 'rgb'
                 img.colorspace = Magick::RGBColorspace
               when 'cmyk'
                 img.colorspace = Magick::CMYKColorspace
               end
               img = yield(img) if block_given?
               img
             end
           end

end