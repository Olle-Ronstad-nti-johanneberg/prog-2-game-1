require 'byebug'
require 'gosu'
require_relative 'basemenu'

class LevelMenu < BaseMenu
    def initialize(window)
        super(window,'','',{},'highscore')

        @levels = YAML.load_file('Level data/levels.yaml')
        @textItems = []
        @textItemsImgs = @levels.map do |level|
            @textItems.push(level['name'])        
            Gosu::Image.from_text(level['name'],LEVELFONTSIZE, {bold: true, font:'impact'})
        end
        @levels.append('Back')
        @textItems.append('Back')
        @textItemsImgs.append(Gosu::Image.from_text('Back',LEVELFONTSIZE, {bold: true, font:'impact'}))
        @maintext = Gosu::Image.from_text('Level Select',MAINFONTSIZE, {bold: true, font: 'impact'})
    end

    def path
        if @menuid.nil?
            return nil
        else
            return @levels[@menuid]
        end
    end
end