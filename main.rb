require 'gosu'

require_relative 'startmenu'
require_relative 'Level.rb'
require_relative 'player.rb'

class Main < Gosu::Window
    def initialize
        super(1280, 720)
        @level = nil
        @startmenu = StartMenu.new(self)
        @player = nil
        @state = "startMenu"
        @pressed = false
        @font = Gosu::Font.new(50, name: "Comic Sans MS")
    end

    def update
        case @state
        when "startMenu"
            if (button_down?(Gosu::MS_LEFT)) && !@startmenu.path.nil?
                @level = Level.new(self,"Level data/#{@startmenu.path}")
                @player = Player.new(self.height, self.width, @level.ground)
                @state = "level"
            end
            if button_down?(Gosu::KB_DOWN)||button_down?(Gosu::KB_S)
                if !@pressed
                    @startmenu.menuselectdown
                    @pressed = true
                end
            end 
            if button_down?(Gosu::KB_UP)||button_down?(Gosu::KB_W)
                if !@pressed
                    @startmenu.menuselectup
                    @pressed = true
                end
            end

            if !(button_down?(Gosu::KB_UP)||button_down?(Gosu::KB_W)||button_down?(Gosu::KB_DOWN)||button_down?(Gosu::KB_S))
                @pressed = false
            end
             
        when "level"
            @player.update
            puts "in level"
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
        end
    end
end

Main.new.show