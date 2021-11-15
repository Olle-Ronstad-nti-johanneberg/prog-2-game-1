require 'Gosu'

class StartMenu
    def initialize(window)
        @window = window
        @levels = Dir.children('./Level Data').map do |name|
            Gosu::Image.from_text(name.gsub(".csv",""),20, {bold: true})
        end
    end

    def draw
        @levels.each_with_index do |level, i|
            level.draw((@window.width-level.width)*0.5,i*25)
        end
    end
end