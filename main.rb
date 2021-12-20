require 'gosu'

require_relative 'levelMenu.rb'
#require_relative 'startMenu.rb'
require_relative 'Level.rb'
require_relative 'player.rb'

class Main < Gosu::Window
    def initialize
        super(1280, 720)
        self.caption = "Lunar Game"
        @level = nil
        @levelmenu = LevelMenu.new(self)
        @player = nil
        @state = "startMenu"
        @pressed = false
        @font = Gosu::Font.new(50, name: "Comic Sans MS")
        @timer = 300
    end

    def update
        case @state
        when "startMenu"
            @levelmenu.update
            if (button_down?(Gosu::MS_LEFT)||button_down?(Gosu::KB_RETURN)) && !@levelmenu.path.nil?
                @level = Level.new(self,"Level data/#{@levelmenu.path}")
                @player = Player.new(self.height, self.width, @level.ground, @level.data)
                @state = "level"
            end

        when "level"
            @player.update
            if (@level.ground.angle(@player.img_x) < @player.angle+10 && @level.ground.angle(@player.img_x) > @player.angle-10) && @player.colliding
                @state = "gameOver"
                @timer = 300
            end

        when "gameOver"
            if (button_down?(Gosu::KB_RETURN))
                @timer = 1
            end
            if @timer == 0
                @state = "startMenu"
            end
            @timer -= 1
        end

        if Gosu.button_down?(Gosu::KbEscape)
            close
            puts "Game closed!"
        end
    end


    def draw
        case @state
        when "startMenu"
            @levelmenu.draw
        when "level"
            @level.draw
            @player.draw
            @font.draw_text(@levelmenu.path.gsub(".csv",""), 0, 0, 0)
        when "gameOver"
            @font.draw_text("Congrats, you finished the level!", 0, 0, 0)
            @level.draw
            @player.draw
        end
    end
end

Main.new.show