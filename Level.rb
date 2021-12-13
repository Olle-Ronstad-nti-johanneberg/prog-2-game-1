require 'csv'

require_relative 'HEXColor.rb'
require_relative 'Ground.rb'
require_relative 'Rockscater'

class Level
    attr_accessor :data

    def initialize(window,levelpath)
        @window = window
        @data = {}
        CSV.foreach(levelpath) do |row|
            if row[1].to_f.to_s == row[1]
                @data[row[0].to_sym] = row[1].to_f
            else
                @data[row[0].to_sym] = row[1]
            end
        end
        @ground = Ground.new(@window,@data[:ground],Hex(@data[:topColor]),Hex(@data[:botomColor]))
        @rockscater = Rockscater.new(@window,@ground,20,1,0.1,@data[:rockIMG])
    end

    def ground
        return @ground
    end

    def draw()
        @ground.draw
        @rockscater.draw
    end
end