require 'Gosu'

MAINFONTSIZE = 75
LEVELFONTSIZE = 20
LEVELFONTTEXTSPACING = 5

class StartMenu
    def initialize(window)
        @window = window
        @levelsPath = Dir.children('./Level Data')
        @levels = @levelsPath.map do |name|
            Gosu::Image.from_text(name.gsub(".csv",""),LEVELFONTSIZE, {bold: true})
        end
        @maintext = Gosu::Image.from_text("LUNAR GAME",MAINFONTSIZE, {bold: true, font: "impact"})
        @leftArrow = Gosu::Image.from_text("<",LEVELFONTSIZE, {bold: true, font: "impact"})
        @rightArrow = Gosu::Image.from_text(">",LEVELFONTSIZE, {bold: true, font: "impact"})

    end

    def draw
        @maintext.draw((@window.width-@maintext.width)*0.5,LEVELFONTSIZE+LEVELFONTTEXTSPACING)
        @levels.each_with_index do |level, i|
            level.draw((@window.width-level.width)*0.5,i*(LEVELFONTSIZE+LEVELFONTTEXTSPACING)+MAINFONTSIZE*1.5)
        end
        hoveringID = idHoveringOver()
        if !hoveringID.nil?
            @leftArrow.draw((@window.width+@levels[hoveringID].width)*0.5,hoveringID*(LEVELFONTSIZE+LEVELFONTTEXTSPACING)+MAINFONTSIZE*1.5)
            @rightArrow.draw((@window.width-@levels[hoveringID].width)*0.5-@rightArrow.width,hoveringID*(LEVELFONTSIZE+LEVELFONTTEXTSPACING)+MAINFONTSIZE*1.5)
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
            tmp = ((@window.mouse_y-MAINFONTSIZE*1.5)/(LEVELFONTSIZE+LEVELFONTTEXTSPACING)).floor
            if tmp < 0 || tmp > @levelsPath.length-1
                return nil
            else
                return tmp
            end
        end
    end

end