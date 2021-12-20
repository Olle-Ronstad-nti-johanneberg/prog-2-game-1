require 'gosu'
require_relative 'basemenu.rb'
TOPSPACING = 50
MAINFONTSIZE = 75
LEVELFONTSIZE = 20
LEVELFONTTEXTSPACING = 5
MAINFONTSPACING = 2

class LevelMenu < BaseMenu
    def initialize(window)
        super(window)

        @levelsPath = Dir.children('Level data')
        @textItems = @levelsPath
        @textItemsImgs = @levelsPath.map do |name|
            Gosu::Image.from_text(name.gsub(".csv",""),LEVELFONTSIZE, {bold: true, font:"impact"})
        end
        @maintext = Gosu::Image.from_text("LUNAR GAME",MAINFONTSIZE, {bold: true, font: "impact"})
    end

    def path
        if @menuid.nil?
            return nil
        else
            return @levelsPath[@menuid]
        end
    end
end