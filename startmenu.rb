require 'gosu'
require_relative 'basemenu.rb'
TOPSPACING = 50
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

    def path
        if @menuid.nil?
            return nil
        else
            return @levelsPath[@menuid]
        end
    end
end