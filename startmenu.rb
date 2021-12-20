require 'gosu'
require_relative 'basemenu.rb'
MAINFONTSIZE = 75
LEVELFONTSIZE = 20
LEVELFONTTEXTSPACING = 5

class StartMenu < BaseMenu
    def initialize(window)
        super(window)

        @levelsPath = Dir.children('Level data')
        @levels = @levelsPath.map do |name|
            Gosu::Image.from_text(name.gsub(".csv",""),LEVELFONTSIZE, {bold: true, font:"impact"})
        end
        @maintext = Gosu::Image.from_text("LUNAR GAME",MAINFONTSIZE, {bold: true, font: "impact"})
        @leftArrow = Gosu::Image.from_text("<",LEVELFONTSIZE, {bold: true, font: "impact"})
        @rightArrow = Gosu::Image.from_text(">",LEVELFONTSIZE, {bold: true, font: "impact"})
        @copyright = Gosu::Image.from_text("© Ronstad, Olle & Söderborg, Viktor",LEVELFONTSIZE, {bold: true, font: "impact"})
        
        @menuid = nil
    end

    def draw
        @maintext.draw((@window.width-@maintext.width)*0.5,LEVELFONTSIZE+LEVELFONTTEXTSPACING)
        @copyright.draw((@window.width-@copyright.width)*0.5, @window.height-50)
        @levels.each_with_index do |level, i|
            level.draw((@window.width-level.width)*0.5,i*(LEVELFONTSIZE+LEVELFONTTEXTSPACING)+MAINFONTSIZE*1.5)
        end
        if movedmouse?
            hoveringID = idHoveringOver()
            @menuid = idHoveringOver()
        else
            hoveringID = @menuid
        end
        if !hoveringID.nil?
            @leftArrow.draw((@window.width+@levels[hoveringID].width)*0.5,hoveringID*(LEVELFONTSIZE+LEVELFONTTEXTSPACING)+MAINFONTSIZE*1.5)
            @rightArrow.draw((@window.width-@levels[hoveringID].width)*0.5-@rightArrow.width,hoveringID*(LEVELFONTSIZE+LEVELFONTTEXTSPACING)+MAINFONTSIZE*1.5)
        end

    end

    def path
        if @menuid.nil?
            return nil
        else
            return @levelsPath[@menuid]
        end
    end
end