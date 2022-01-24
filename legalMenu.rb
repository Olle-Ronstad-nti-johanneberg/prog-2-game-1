require 'gosu'
require_relative 'basemenu.rb'

class LegalMenu < BaseMenu
    def initialize(window)
        super(window)
        @extratextImg =  Gosu::Image.from_text(Gosu::LICENSES,LEVELFONTSIZE, {bold: true, font: "impact"})
        @states = ["startMenu"]
        @textItems = ["Back"]
        @textItemsImgs = @textItems.map do |name|
            Gosu::Image.from_text(name,LEVELFONTSIZE, {bold: true, font:"impact"})
        end
        @maintext = Gosu::Image.from_text("Legal Info",MAINFONTSIZE, {bold: true, font: "impact"})
    end

    def newState
        if @menuid.nil?
            return "legal"
        else
            return @states[@menuid]
        end
    end
end