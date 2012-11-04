module ImageManipulators

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

end