require 'Gosu'
require_relative 'Ground.rb'
require_relative 'Rockscater.rb'


class Main < Gosu::Window
    def initialize
        super(640, 480)
        @ground = Ground.new(self,"Ground data/debug.csv",Gosu::Color.argb(0xff_ffffff),Gosu::Color.argb(0xff_000000))
        @rock = Rock.new(self,640/2,200,2,0.1,'nedladdning.jpg')
        @rockscater = Rockscater.new(self,@ground,100,@rock)
    end

    def draw
        @ground.draw
        @rockscater.draw
    end
end

Main.new.show