require_relative 'Ground.rb'

class Rock
    attr_accessor :x, :y

    def initialize(window,x,y,z,size,img)
        @window = window
        @size = (rand()+0.5)*size
        @img = Gosu::Image.new(img)
        @x = x - @img.width*@size/2
        @y = y - @img.height*@size/2
        @z = z
    end

    def draw()
        @img.draw(@x,@y,@z,scale_x = @size, scale_y = @size)
    end
end

class Rockscater

    def initialize(window,ground,amount,refRock)
        @window = window
        @ground = ground
        @rockAry = Array.new(amount) do |rock|
            rock = refRock.dup
            rock.x = rand()*window.width
            rock.y = window.height - ground.groundY(rock.x)
            rock
        end
        puts @rockAry[0].x
        puts @rockAry[0].y
    end

    def draw()
        @rockAry.each do |rock|
            rock.draw
        end
    end
end