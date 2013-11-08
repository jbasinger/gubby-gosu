require 'gosu'
require 'gubby'
require 'gubby/gosu'
require 'ruby-prof'

include Gubby
include Gubby::Systems
include Gubby::Components

class MyWindow < Gosu::Window
  
	def initialize
    #super 640, 480, false
		super 1024, 768, false
    self.caption = 'Braaaains!'
		
		@zombie = GameEntity.new("zombie",Sprite2D, Position2D, Color)
		@zombie.load(self,"assets/zombie.png",false)
		@zombie.x = 100
		@zombie.y = 150
		
		@engine = GameEngine.new(GosuRenderSystem.new())
		
		@engine.add_entity(@zombie)
		
  end
	
	def draw
		@engine.run(:draw)
	end
	
	def update
		
		@engine.run(:update)
		
		if button_down? Gosu::KbEscape then
			close
		end
		
	end
	
end

#RubyProf.start

window = MyWindow.new
window.show

#profile = RubyProf.stop
#RubyProf::FlatPrinter.new(profile).print(File.open("profile.txt","w+"))