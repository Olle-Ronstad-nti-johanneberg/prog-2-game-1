require 'yaml'

require_relative 'hex_color'
require_relative 'ground'
require_relative 'Rockscater'

# Generate level
class Level
  attr_reader :ground
  attr_accessor :data

  def initialize(window, data)
    @window = window
    @data = data
    @ground = Ground.new(@window, @data['ground'], hex(@data['top_color']), hex(@data['bottom_color']))
    @rockscater = Rockscater.new(@window, @ground, 20, 0, 1, @data['rockIMG'])
  end

  def draw
    @ground.draw
    @rockscater.draw
  end
end
