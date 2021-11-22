require 'Gosu'

require_relative 'startmenu'
require_relative 'Level.rb'

class Main < Gosu::Window
    def initialize
        super(640, 480)
        @level = nil
        @startmenu = StartMenu.new(self)
        @state = "startMenu"
    end

    def update
        case @state
        when "startMenu"
            if button_down?(Gosu::MS_LEFT) && !@startmenu.hoveringOverPath.nil?
                @level = Level.new(self,"Level data/#{@startmenu.hoveringOverPath}")
                @state = "level"
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