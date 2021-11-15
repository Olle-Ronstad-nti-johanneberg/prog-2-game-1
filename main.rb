require 'Gosu'

require_relative 'startmenu'
require_relative 'Level.rb'

class Main < Gosu::Window
    def initialize
        super(640, 480)
        @level = Level.new(self,'Level data/testLevel.csv')
        @startmenu = StartMenu.new(self)
        @state = "startMenu"
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