require 'Gosu'

GRILLKORV = 75

class StartMenu
    def initialize(window)
        @window = window
        @levelsPath = Dir.children('./Level Data')
        @levels = Dir.children('./Level Data').map do |name|
            Gosu::Image.from_text(name.gsub(".csv",""),20, {bold: true})
        end
        @maintext = Gosu::Image.from_text("LUNAR GAME",GRILLKORV, {bold: true, font: "impact"})
        @leftArrow = Gosu::Image.from_text("<",20, {bold: true, font: "impact"})
        @rightArrow = Gosu::Image.from_text(">",20, {bold: true, font: "impact"})

    end

    def draw
        @maintext.draw((@window.width-@maintext.width)*0.5,25)
        @levels.each_with_index do |level, i|
            level.draw((@window.width-level.width)*0.5,i*25+125)
        end
        hoveringID = idHoveringOver()
        if !hoveringID.nil?
            @leftArrow.draw((@window.width+@levels[hoveringID].width)*0.5,hoveringID*25+125)
            @rightArrow.draw((@window.width-@levels[hoveringID].width)*0.5-@rightArrow.width,hoveringID*25+125)
        end

    end

    def hoveringOverPath
        hoveringID = idHoveringOver()
        if hoveringID.nil?
            return nil
        else
            return @levelsPath[hoveringID]
        end
    end

    private

    def idHoveringOver
        if @window.mouse_x > @window.width/4 && @window.mouse_x < @window.width/4*3
            tmp = ((@window.mouse_y-125)/25).floor
            if tmp < 0 || tmp > @levelsPath.length-1
                return nil
            else
                return tmp
            end
        end
    end

end