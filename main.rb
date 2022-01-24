require 'gosu'

require_relative 'legalMenu.rb'
require_relative 'levelMenu.rb'
require_relative 'startmenu.rb'
require_relative 'Level.rb'
require_relative 'player.rb'

class Main < Gosu::Window
    def initialize
        super(1280, 720)
        self.caption = "Lunar Game"
        @level = nil
        @levelmenu = LevelMenu.new(self)
        @startmenu = StartMenu.new(self)
        @legalmenu = LegalMenu.new(self)
        @player = nil
        @state = "startMenu"
        @pressed = false
        @font = Gosu::Font.new(50, name: "Comic Sans MS")
        @score = nil
    end

    def update
        case @state
        when "startMenu"
            @startmenu.update
            if (button_down?(Gosu::MS_LEFT)||button_down?(Gosu::KB_RETURN)) && @pressed == false
                @state = @startmenu.newState
                @pressed = true
            end

        when "levelMenu"
            @levelmenu.update
            if (button_down?(Gosu::MS_LEFT)||button_down?(Gosu::KB_RETURN)) && !@levelmenu.path.nil? && @pressed == false
                if @levelmenu.path == "Back"
                    @state = "startMenu"
                else
                    @level = Level.new(self,"Level data/#{@levelmenu.path}")
                    @player = Player.new(self.height, self.width, @level.ground, @level.data)
                    @state = "level"
                end
                @pressed = true
            end

        when "legal"
            @legalmenu.update
            if (button_down?(Gosu::MS_LEFT)||button_down?(Gosu::KB_RETURN)) && @pressed == false
                @state = @legalmenu.newState
                @pressed = true
            end

        when "level"
            @player.update
            if (@level.ground.angle(@player.img_x) < @player.angle+25 && @level.ground.angle(@player.img_x) > @player.angle-25) && @player.colliding
                @state = "landed"
            elsif !((@level.ground.angle(@player.img_x) > @player.angle+25 && @level.ground.angle(@player.img_x) < @player.angle-25)) && @player.colliding
                @state = "crashed"
            end

        when "landed"
            if (button_down?(Gosu::KB_SPACE))
                @state = "startMenu"
            end
            @score = 10000/(Math.sqrt(@player.vel_x**2 + @player.vel_y**2) + 1)
        when "exit"
            close

        when "crashed"
            if (button_down?(Gosu::KB_SPACE))
                @state = "startMenu"
            end
        end

        if !(button_down?(Gosu::MS_LEFT)||button_down?(Gosu::KB_RETURN))
            @pressed = false
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
        when "levelMenu"
            @levelmenu.draw
        when "legal"
            @legalmenu.draw
        when "level"
            @level.draw
            @player.draw
            @font.draw_text(@levelmenu.path.gsub(".csv",""), 0, 0, 0)
        when "landed"
            @font.draw_text("Congrats, you finished the level! Press SPACE to continue!", 0, 0, 0)
            @font.draw_text("Score: #{@score.to_i}", 0, 50, 0)
            @level.draw
            @player.draw
        when "crashed"
            @font.draw_text("You crashed! Press SPACE to continue!", 0, 0, 0)
            @font.draw_text("Score: 0", 0, 50, 0)
            @level.draw
            @player.draw
        end
    end
end

Main.new.show