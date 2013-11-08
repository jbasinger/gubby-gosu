module Gubby
  module Components
		module Color
			
			attr_accessor :color
			
			def component_added()
				self.color = Gosu::Color.new(0xffffffff)
			end
			
		end
	end
end