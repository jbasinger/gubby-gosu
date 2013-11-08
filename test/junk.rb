
module Outside
	class Thingie
		def hi
			puts "hi"
		end
	end
end


module A
	module B
		module C
			x = Outside::Thingie.new
			x.hi
		end
	end
end


