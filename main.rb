require 'Gosu'

require_relative 'Level.rb'

class Main < Gosu::Window
    def initialize
        super(640, 480)
        @level = Level.new(self,'Level data/testLevel.csv')
    end

    def draw
        @level.draw
    end
end

Main.new.show