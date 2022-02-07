require 'gosu'

# lower numbers gives higer prcision at the cost of preformance
COLLISION_DETAIL = 0.05
THRUST = 0.25
TURNSPEED = 2.5

class Player

    attr_accessor :gravity, :angle, :img_x, :vel_x, :vel_y

    def initialize(height, width, ground, data)
        @player_active = Gosu::Image.load_tiles('assets/Vrocket_thrust.png', 64, 64, options = {retro: true})
        @player_idle = Gosu::Image.load_tiles('assets/Vrocket_idle.png', 64, 64, options = {retro: true})
        # @img_x = 
        @img_y = @vel_x = @vel_y = 0
        @angle = rand(0..90)
        @img_x = rand(0..width)
        @gravity = data["grav"]
        @scale_x = 2
        @scale_y = 2
        @height = height
        @width = width
        @ground = ground
        @animation_state = 0
        @moving = false
    end

    def colliding()
        @img_y > @height-@ground.groundY(@img_x) - 18
    end

    def update
        @vel_y += @gravity
        @angle = @angle%360
        if @img_y < 30
            @img_y = 30
            @vel_y = 0
        elsif colliding()
            while @img_y > @height-@ground.groundY(@img_x) - 18
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
            @vel_x += Math::sin(@angle*Math::PI/180)*THRUST
            @vel_y += Math::cos(@angle*Math::PI/180)*-THRUST
            @moving = true
        else
            @moving = false
        end
            
        if Gosu.button_down? Gosu::KB_A or Gosu.button_down? Gosu::KB_LEFT
            @angle -= TURNSPEED
        end
        
        if Gosu.button_down? Gosu::KB_D or Gosu.button_down? Gosu::KB_RIGHT
            @angle += TURNSPEED
        end
    
        @img_y += @vel_y
        @img_x += @vel_x
    end
    
    def draw
        if @moving
            @player_active[@animation_state/10].draw_rot(@img_x, @img_y, 0, @angle, center_x = 0.5, center_y = 0.5, scale_x = @scale_x, scale_y = @scale_y)
            @animation_state = (@animation_state + 1) % 30
        else
            @player_idle[0].draw_rot(@img_x, @img_y, 0, @angle, center_x = 0.5, center_y = 0.5, scale_x = @scale_x, scale_y = @scale_y)
        end
    end
end
