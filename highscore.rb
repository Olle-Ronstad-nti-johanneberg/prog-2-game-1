require 'gosu'
require_relative 'basemenu.rb'

class Highscore < BaseMenu
    def initialize(window)
        super(window)
        @data = YAML.load_file('highscore.yaml')
        @extratextImg = @data.each.map do |key|
            (key["name"] + " : " + key["score"].to_s)
        end.join("\n")
        @extratextImg = Gosu::Image.from_text(@extratextImg,LEVELFONTSIZE, {bold: true, font: "impact"})
        @states = ["startMenu"]
        @textItems = ["Back"]
        @textItemsImgs = [Gosu::Image.from_text("Back",LEVELFONTSIZE, {bold: true, font: "impact"})]
        @maintext = Gosu::Image.from_text("Highscore",MAINFONTSIZE, {bold: true, font: "impact"})
    end

    def newState
        if @menuid.nil?
            return "highscore"
        else
            return @states[@menuid]
        end
    end
end