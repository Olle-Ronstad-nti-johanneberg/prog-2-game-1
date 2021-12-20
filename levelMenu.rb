require 'gosu'
require_relative 'basemenu.rb'

class LevelMenu < BaseMenu
    def initialize(window)
        super(window)

        @levelsPath = Dir.children('Level data')
        @textItems = @levelsPath
        @textItemsImgs = @levelsPath.map do |name|
            Gosu::Image.from_text(name.gsub(".csv",""),LEVELFONTSIZE, {bold: true, font:"impact"})
        end
        @maintext = Gosu::Image.from_text("level select",MAINFONTSIZE, {bold: true, font: "impact"})
    end

    def path
        if @menuid.nil?
            return nil
        else
            return @levelsPath[@menuid]
        end
    end
end