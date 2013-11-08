
module Gubby
  module Components
		module Font
			
			attr_accessor :font
			attr_accessor :text
			
			def load_font(window, font_name, height)

				@font = Gosu::Font.new(window,font_name,height)
				
			end
		end
	end
end