require 'gosu'
require_relative 'basemenu.rb'

class SettingsMenu < BaseMenu
    def initialize(window)
        super(window)
        @extratextImg =  Gosu::Image.from_text("SIKE! We don't have energy to create this",LEVELFONTSIZE, {bold: true, font: "impact"})
        @states = ["startMenu"]
        @textItems = ["Back"]
        @textItemsImgs = @textItems.map do |name|
            Gosu::Image.from_text(name,LEVELFONTSIZE, {bold: true, font:"impact"})
        end
        @maintext = Gosu::Image.from_text("Settings",MAINFONTSIZE, {bold: true, font: "impact"})
    end

    def newState
        if @menuid.nil?
            return "settingsMenu"
        else
            return @states[@menuid]
        end
    end
end