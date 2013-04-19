module Gubby
	module Systems
		class GosuRenderSystem < GameSystem
			
			def initialize()
				super(Position2D, Sprite2D, Color)
			end
			
			def draw()
				@entities.each do |e|
					e.image.draw_rot(e.x, e.y, e.z, e.angle, e.center_x, e.center_y, e.factor_x, e.factor_y, e.color)
				end
			end
			
		end
	end
end