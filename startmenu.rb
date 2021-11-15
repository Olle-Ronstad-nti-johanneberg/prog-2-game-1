require 'Gosu'

class StartMenu
    def initialize(window)
        @window = window
        @levels = Dir.children('./Level Data').map do |name|
            Gosu::Image.from_text(name.gsub(".csv",""),20, {bold: true})
        end
        @maintext = Gosu::Image.from_text("LUNAR GAME",75, {bold: true, font: "impact"})
    end

    def draw
        @maintext.draw((@window.width-@maintext.width)*0.5,25)
        @levels.each_with_index do |level, i|
            level.draw((@window.width-level.width)*0.5,i*25+125)
        end
    end
end