require 'Gosu'

require_relative 'startmenu'
require_relative 'Level.rb'

class Main < Gosu::Window
    def initialize
        super(1280, 720)
        @level = nil
        @startmenu = StartMenu.new(self)
        @state = "startMenu"
        @pressed = false
    end

    def update
        case @state
        when "startMenu"
            if (button_down?(Gosu::MS_LEFT)) && !@startmenu.path.nil?
                @level = Level.new(self,"Level data/#{@startmenu.path}")
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
            puts "in level"
        end
    end


    def draw
        case @state
        when "startMenu"
            @startmenu.draw
        when "level"
            @level.draw
        end
    end
end

Main.new.show