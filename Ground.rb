require 'byebug'
require 'Gosu'


class Ground
    def initialize(window,file,topColor,botomColor)
        @window = window
        @vertex = File.read(file)
        @vertex = @vertex.split(",").map do |vertex|
            vertex = vertex.split(":")
            vertex[0] = vertex[0].to_f
            vertex[1] = vertex[1].to_f
            vertex
        end
        @vertex = @vertex.sort_by{|x,y|x}
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
                @vertex[i][0], 480-@vertex[i][1],@topColor,
                @vertex[i+1][0], 480-@vertex[i+1][1],@topColor,
                @vertex[i][0],480,@botomColor,
                @vertex[i+1][0], 480,@botomColor
            )
        end
    end

    private


    def leftVertex(x)
        for i in 0..@vertex.length()
            if @vertex[i][0] > x
                return @vertex[i-1]
            end
        end
    end
    
    def rightVertex(x)
        for i in 0..@vertex.length()
            if @vertex[i][0] >= x
                return @vertex[i]
            end
        end
    end
end