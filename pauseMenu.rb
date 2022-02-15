require_relative 'basemenu.rb'
require_relative 'HEXColor.rb'

class PauseMenu < BaseMenu
    def initialize(window,maintext,extraText,textStateHash,selfstate)
        super(window,maintext,extraText,textStateHash,selfstate)
        @color = Hex("#9f000000")

    end
    def draw()
        @window.draw_rect(0, 0, @window.width, @window.height, @color)
        super
    end
end