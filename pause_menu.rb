require_relative 'basemenu'
require_relative 'hex_color'

# Pause Menu
class PauseMenu < BaseMenu
  def initialize(window, maintext, extra_text, text_state_hash, selfstate)
    super(window, maintext, extra_text, text_state_hash, selfstate)
    @color = hex('#9f000000')
  end

  def draw
    @window.draw_rect(0, 0, @window.width, @window.height, @color)
    super
  end
end
