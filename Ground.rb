require 'byebug'
require 'gosu'

# Creates ground for level
class Ground
  def initialize(window, file, top_color, bottom_color)
    @window = window
    @vertex = File.read(file).split(',').map do |vertex|
      vertex = vertex.split(':')
      vertex[0] = vertex[0].to_f
      vertex[1] = vertex[1].to_f
      vertex
    end.sort_by! { |x, y| x }
    @top_color = top_color
    @bottom_color = bottom_color
  end

  def ground_y(x)
    left = left_vertex(x)
    right = right_vertex(x)
    if left[0] == x
      return left[1]
    end

    delta_x = right[0] - left[0]
    along = (x - left[0]) / delta_x
    deltay = left[1] - right[1]
    left[1] - deltay * along
  end

  def draw
    for i in 0..@vertex.length - 2
      @window.draw_quad(
        @vertex[i][0], @window.height - @vertex[i][1], @top_color,
        @vertex[i + 1][0], @window.height - @vertex[i + 1][1], @top_color,
        @vertex[i][0], @window.height, @bottom_color,
        @vertex[i + 1][0], @window.height, @bottom_color
      )
    end
  end

  def angle(x)
    left = left_vertex(x)
    right = right_vertex(x)
    angel = (-Math::tanh((left[1] - right[1]) / (left[0] - right[0])) * (180 / Math::PI)) % 360
  end

  private

  def left_vertex(x)
    @vertex.each_with_index do |vertex, i|
      if @vertex[i][0] > x
        return @vertex[i - 1]
      end
    end
    @vertex[-1]
  end

  def right_vertex(x)
    @vertex.each do |vertex|
      if vertex[0] >= x
        return vertex
      end
    end
    @vertex[-1]
  end
end
