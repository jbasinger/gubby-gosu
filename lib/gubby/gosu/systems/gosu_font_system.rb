module Gubby
	module Systems
		class GosuRenderSystem < GameSystem
			
			def initialize()
				super(Position2D, Font, Color)
			end
			
			def draw()
				@entities.each do |e|
					e.font.draw(e.text, e.x, e.y, e.z, e.factor_x, e.factor_y, e.color)
				end
			end
			
		end
	end
end