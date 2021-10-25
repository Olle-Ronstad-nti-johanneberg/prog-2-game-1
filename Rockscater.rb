require_relative 'Ground.rb'

class Rock
    attr_accessor :x, :y

    def initialize(window,x,y,z,size,img)
        @window = window
        @size = (rand()+0.5)*size
        @img = Gosu::Image.new(img)
        @x = x-(@img.width*@size)*0.5
        @y = y-(@img.height*@size)*0.5+15
        @z = z
    end

    def draw()
        @img.draw(@x,@y,@z,scale_x = @size, scale_y = @size)
    end
end

class Rockscater

    def initialize(window,ground,amount,z,size,img)
        @window = window
        @ground = ground
        @rockAry = Array.new(amount) do |rock|
            tmp=rand()*window.width
            Rock.new(window,tmp,window.height - ground.groundY(tmp),z,size,img)
        end
    end

    def draw()
        @rockAry.each do |rock|
            rock.draw
        end
    end
end