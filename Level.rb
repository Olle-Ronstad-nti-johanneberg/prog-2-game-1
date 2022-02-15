require 'yaml'

require_relative 'HEXColor.rb'
require_relative 'Ground.rb'
require_relative 'Rockscater'

class Level
    attr_reader :ground
    attr_accessor :data

    def initialize(window,data)
        @window = window
        @data = data
        @ground = Ground.new(@window,@data["ground"],Hex(@data["topColor"]),Hex(@data["botomColor"]))
        @rockscater = Rockscater.new(@window,@ground,20,0,1,@data["rockIMG"])
    end

    def draw()
        @ground.draw
        @rockscater.draw
    end
end