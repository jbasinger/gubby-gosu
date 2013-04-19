require 'gosu'
require 'gubby'
require 'gubby/gosu'
require 'ruby-prof'

include Gubby
include Gubby::Systems
include Gubby::Components

include Gubby::Gosu::Systems
include Gubby::Gosu::Components

#Cheap out for moving and stuff.
#Probably not the best example. Should be a move system or something.
class UpdateSystem < GameSystem
	
	def initialize()
		super(Update)
	end
	
	def update()
		@entities.each do |e|
			if e.update.is_a?(Symbol) then
				e.send(e.update)
			end
			if e.update.is_a?(Proc) then
				e.update.call
			end
		end
	end
	
end

class PopSystem < GameSystem
	
	def initialize(window)
		super(Poppable, Sprite2D, Position2D)
		@window = window
	end
	
	def button_down()

		bloon = @entities.reject{|e| 
			e.popped == true || ((e.y + e.image.height/2) < 0 || (e.y + e.image.height/2) > @window.height)
		}.sample
		bloon.popped = true unless bloon.nil?
		
		@entities.each do |e|
			
			if e.popped && e.poppable then
				e.poppable = false
				e.load(@window,"asset/popped.png",false)
				e.speed = 5 + rand(1..e.speed*2)
				e.sounds.sample.play
			end
		
		end
		
	end
	
end

module Update
	
	attr_accessor :update
	
	def Update.extend_object(e)
		super(e)
		e.update = Proc.new(){}
	end
	
end

module Poppable
	attr_accessor :popped, :poppable
	
	def Poppable.extend_object(e)
		super(e)
		e.popped = false
		e.poppable = true
	end
	
end

module Speed
	attr_accessor :speed
end

class Bloon < GameEntity
	
	attr_reader :sounds
	
	def initialize(window)
		super("bloon", Sprite2D, Position2D, Color, Update, Poppable, Speed)
		
		@window = window
		self.speed = rand(1..5)
		
		load(window,"asset/bloon.png", false)
		
		self.x = rand(0+self.image.width/2..window.width-self.image.width/2)
		self.y = 0 - rand(self.image.height/2..self.image.height*3)
		
		self.color = Gosu::Color.new(0xff000000)
    self.color.red = rand(40..255)
    self.color.green = rand(40..255)
    self.color.blue = rand(40..255)
		
		self.update = :move
		
		@sounds = []
		(1..5).each do |i|
			@sounds << Gosu::Sample.new(window, "asset/p#{i.to_s}.wav")
		end
		
	end
	
	def move()
	
		self.y += self.speed
		
		if self.popped then
			self.angle += self.speed/2
		end
		
		if (self.y + self.image.width/2) > @window.height then
			self.destroy()
		end
		
	end
	
end

class MyWindow < Gosu::Window
  
	def initialize
    #super 640, 480, false
		super 1024, 768, true
    self.caption = 'Pop the bloons!'
		
		@engine = GameEngine.new(GosuRenderSystem.new(), UpdateSystem.new(), PopSystem.new(self))
		@max_bloons = 40
		
  end
	
	def draw
		@engine.run(:draw)
	end
	
	def update
		
		
		
		@engine.run(:update)
		
		if @engine.entities.count < @max_bloons then
			@engine.add_entity(Bloon.new(self))
		end
		
		if button_down? Gosu::KbEscape then
			close
		end
		
		
		
	end
	
	def button_down(id)
		@engine.run(:button_down)
	end
	
end

RubyProf.start

window = MyWindow.new
window.show

profile = RubyProf.stop
RubyProf::FlatPrinter.new(profile).print(File.open("profile.txt","w+"))