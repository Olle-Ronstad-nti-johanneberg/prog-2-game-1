require 'Gosu'
require_relative 'Ground.rb'
require_relative 'Rockscater.rb'


class Main < Gosu::Window
    def initialize
        super(640, 480)
        @ground = Ground.new(self,"Ground data/ground1.csv",Gosu::Color.argb(0xff_ffffff),Gosu::Color.argb(0xff_000000))
        @rockscater = Rockscater.new(self,@ground,10,1,0.1,'nedladdning.jpg')
    end

    def draw
        @ground.draw
        @rockscater.draw
    end
end

Main.new.show