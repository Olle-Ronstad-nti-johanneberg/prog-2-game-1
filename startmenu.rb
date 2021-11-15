require 'Gosu'

class StartMenu
    def initialize(window)
        @window = window
        @levels = Dir.children('./Level Data').map do |name|
            Gosu::Image.from_text(name,20)
        end
    end

    def draw
        @levels.each_with_index do |level, i|
            level.draw(0,i*25)
        end
    end
end