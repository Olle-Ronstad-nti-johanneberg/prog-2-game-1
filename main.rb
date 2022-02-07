require 'gosu'

require_relative 'legalMenu.rb'
require_relative 'levelMenu.rb'
require_relative 'startmenu.rb'
require_relative 'Level.rb'
require_relative 'player.rb'
require_relative 'settingsmenu.rb'
require_relative 'highscore.rb'

class Main < Gosu::Window
    def initialize
        super(1280, 720)
        self.caption = "Lunar Game"
        @level = nil
        @levelmenu = LevelMenu.new(self)
        @startmenu = StartMenu.new(self)
        @legalmenu = LegalMenu.new(self)
        @settingsmenu = SettingsMenu.new(self)
        @highscoremenu = Highscore.new(self)
        @player = nil
        @state = "startMenu"
        @pressed = false
        @font = Gosu::Font.new(50, name: "Comic Sans MS")
        @score = nil
        @highscore = YAML.load_file("highscore.yaml")
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
                    @level = Level.new(self, @levelmenu.path)
                    @player = Player.new(self.height, self.width, @level.ground, @level.data)
                    @state = "level"
                end
                @pressed = true
            end
        
        when "highscore"
            @highscoremenu.update
            if (button_down?(Gosu::MS_LEFT))||button_down?(Gosu::KB_RETURN) && @pressed == false
                @state = @highscoremenu.newState
                @pressed = true
            end

            
        when "legal"
            @legalmenu.update
            if (button_down?(Gosu::MS_LEFT)||button_down?(Gosu::KB_RETURN)) && @pressed == false
                @state = @legalmenu.newState
                @pressed = true
            end

        when "settingsMenu"
            @settingsmenu.update
            if (button_down?(Gosu::MS_LEFT)||button_down?(Gosu::KB_RETURN)) && @pressed == false
                @state = @settingsmenu.newState
                @pressed = true
            end

        when "level"
            @player.update
            if (@level.ground.angle(@player.img_x) < @player.angle+25 && @level.ground.angle(@player.img_x) > @player.angle-25) && @player.colliding
                @state = "landed"
            elsif !((@level.ground.angle(@player.img_x) > @player.angle+25 && @level.ground.angle(@player.img_x) < @player.angle-25)) && @player.colliding
                @state = "crashed"
            end
            if Gosu.button_down?(Gosu::KbEscape)
                @state ="levelMenu"
            end

        when "landed"
            if (button_down?(Gosu::KB_SPACE))
                @state = "startMenu"
            end
            @score = 10000/(Math.sqrt(@player.vel_x**2 + @player.vel_y**2) + 1)
            @highscore[0]["#{@levelmenu.path["name"]}"] = @score
        when "exit"
            close

        when "crashed"
            if (button_down?(Gosu::KB_SPACE))
                @state = "startMenu"
                @highscore[0]["#{@levelmenu.path["name"]}"] = 0
            end
        end

        if !(button_down?(Gosu::MS_LEFT)||button_down?(Gosu::KB_RETURN))
            @pressed = false
        end
    end


    def draw
        case @state
        when "startMenu"
           @startmenu.draw
        when "levelMenu"
            @levelmenu.draw
        when "highscore"
            @highscoremenu.draw
        when "legal"
            @legalmenu.draw
        when "settingsMenu"
            @settingsmenu.draw
        when "level"
            @level.draw
            @player.draw
            @font.draw_text(@levelmenu.path["name"], 0, 0, 0)
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