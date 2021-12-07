require 'gosu'

# lower numbers gives higer prcision at the cost of preformance
COLLISION_DETAIL = 0.05

class Player < Gosu::Window

    attr_accessor :gravity

    def initialize(height, width, ground)
        # super(800, 600)
        # self.caption = "Player"
        # @background = Gosu::Color::WHITE
        @player = Gosu::Image.load_tiles('Sprite-rocket.png', 32, 32, options = {retro: true})
        @img_x = 0
        @img_y = 0
        @angle = 0
        @vel_x = 0
        @vel_y = 0
        @gravity = 0.1
        @scale_x = 2
        @scale_y = 2
        @height = height
        @width = width
        @ground = ground
        @animation_state = 0
    end
    
    
    def update
        @vel_y += @gravity
        @angle = @angle%360
        if @img_y < 30
            @img_y = 30
            @vel_y = 0
        elsif @img_y > @height-@ground.groundY(@img_x) - 30
            while @img_y > @height-@ground.groundY(@img_x) - 30
                @img_y -= @vel_y * COLLISION_DETAIL
                @img_x -= @vel_x * COLLISION_DETAIL
            end
            @vel_y = 0
            @vel_x = 0
        end
    
        if @img_x < 20
            @img_x = 20
            @vel_x = 0
        elsif (@img_x*@scale_x)-@width > @width-50
            @img_x = @width-25
            @vel_x = 0
        end
    
        if Gosu.button_down? Gosu::KB_W or Gosu.button_down? Gosu::KB_UP
            @vel_x += Math::sin(@angle*Math::PI/180)*0.25
            @vel_y += Math::cos(@angle*Math::PI/180)*-0.25
        end
            
        if Gosu.button_down? Gosu::KB_A or Gosu.button_down? Gosu::KB_LEFT
            @angle -= 2.5
        end
            
        if Gosu.button_down? Gosu::KB_D or Gosu.button_down? Gosu::KB_RIGHT
            @angle += 2.5
        end
    
        @img_y += @vel_y
        @img_x += @vel_x
        # end
    end
    
    def draw
        @player[@animation_state/10].draw_rot(@img_x, @img_y, 0, @angle, center_x = 0.5, center_y = 0.5, scale_x = @scale_x, scale_y = @scale_y)
        @animation_state = (@animation_state + 1) % 50
    end
end