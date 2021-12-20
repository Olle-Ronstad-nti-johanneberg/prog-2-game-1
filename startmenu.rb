require 'gosu'
require_relative 'basemenu.rb'

class StartMenu < BaseMenu
    def initialize(window)
        super(window)
        @states = ["levelMenu","settingsMenu","legal","exit"]
        @textItems = ["Level Select","Settings","Legal","Exit"]
        @textItemsImgs = @textItems.map do |name|
            Gosu::Image.from_text(name,LEVELFONTSIZE, {bold: true, font:"impact"})
        end
        @maintext = Gosu::Image.from_text("LUNAR GAME",MAINFONTSIZE, {bold: true, font: "impact"})
    end

    def newState
        if @menuid.nil?
            return "startMenu"
        else
            return @states[@menuid]
        end
    end
end