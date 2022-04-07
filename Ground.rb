require 'byebug'
require 'gosu'


class Ground
    def initialize(window,file,topColor,botomColor)
        @window = window
        @vertex = File.read(file).split(',').map do |vertex|
            vertex = vertex.split(':')
            vertex[0] = vertex[0].to_f
            vertex[1] = vertex[1].to_f
            vertex
        end.sort_by!{|x,y|x}
        @topColor = topColor
        @botomColor = botomColor
    end

    def groundY(x)
        left = leftVertex(x)
        right = rightVertex(x)
        if left[0]==x
            return left[1]
        end

        deltaX = right[0]-left[0]
        along = (x-left[0])/deltaX
        deltay = left[1]-right[1]
        return left[1]-deltay*along
    end

    def draw()
        for i in 0..@vertex.length-2
            @window.draw_quad(
                @vertex[i][0], @window.height-@vertex[i][1],@topColor,
                @vertex[i+1][0], @window.height-@vertex[i+1][1],@topColor,
                @vertex[i][0],@window.height,@botomColor,
                @vertex[i+1][0], @window.height,@botomColor
            )
        end
    end

    def angle(x)
        left = leftVertex(x)
        right = rightVertex(x)
        angel = (-Math::tanh((left[1]-right[1])/(left[0]-right[0]))*(180/Math::PI))%360
    end

    private


    def leftVertex(x)
        @vertex.each_with_index do |vertex, i|
            if @vertex[i][0] > x
                return @vertex[i-1]
            end
        end
        @vertex[-1]
    end
    
    def rightVertex(x)
        @vertex.each do |vertex|
            if vertex[0] >= x
                return vertex
            end
        end
        @vertex[-1]
    end
end