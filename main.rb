require 'gosu'

require_relative 'startmenu'
require_relative 'Level.rb'
require_relative 'player.rb'

class Main < Gosu::Window
    def initialize
        super(1280, 720)
        self.caption = "Lunar Game"
        @level = nil
        @startmenu = StartMenu.new(self)
        @player = nil
        @state = "startMenu"
        @pressed = false
        @font = Gosu::Font.new(50, name: "Comic Sans MS")
        @timer = 300
    end

    def update
        case @state
        when "startMenu"
            @startmenu.update
            if (button_down?(Gosu::MS_LEFT)||button_down?(Gosu::KB_RETURN)) && !@startmenu.path.nil?
                @level = Level.new(self,"Level data/#{@startmenu.path}")
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
            @startmenu.draw
        when "level"
            @level.draw
            @player.draw
            @font.draw_text(@startmenu.path.gsub(".csv",""), 0, 0, 0)
        when "gameOver"
            @font.draw_text("Congrats, you finished the level!", 0, 0, 0)
            @level.draw
            @player.draw
            if @timer == 0
                @state = "startMenu"
            end
        end
    end
end

Main.new.show