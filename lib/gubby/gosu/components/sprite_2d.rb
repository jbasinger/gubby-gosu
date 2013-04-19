
module Gubby
  module Components
		module Sprite2D
			
			attr_accessor :image
			
			def load(window, filename, tileable)
				
				@image = Gosu::Image.new(window, filename, tileable)
				
			end
		end
	end
end