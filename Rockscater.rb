require_relative 'ground'

# Rock
class Rock
  attr_accessor :x, :y

  def initialize(window, x, y, z, size, img)
    @window = window
    @size = (rand + 0.5) * size
    @img = Gosu::Image.new(img, { retro: true })
    @x = x - (@img.width * @size) * 0.5
    @y = y - (@img.height * @size) * 0.5
    @z = z
  end

  def draw
    @img.draw(@x, @y, @z, @size, @size)
  end
end

# Rockscater
class Rockscater
  def initialize(window, ground, amount, z, size, img)
    @window = window
    @ground = ground
    @rock_ary = Array.new(amount) do
      tmp = rand * window.width
      Rock.new(window, tmp, window.height - ground.ground_y(tmp), z, size, img)
    end
  end

  def draw
    @rock_ary.each do |rock|
      rock.draw
    end
  end
end
