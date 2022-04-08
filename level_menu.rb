require 'byebug'
require 'gosu'
require_relative 'basemenu'

# Level Menu
class LevelMenu < BaseMenu
  def initialize(window)
    super(window, '', '', {}, 'highscore')

    @levels = YAML.load_file('Level data/levels.yaml')
    @text_items = []
    @text_items_imgs = @levels.map do |level|
      @text_items.push(level['name'])
      Gosu::Image.from_text(level['name'], LEVELFONTSIZE, { bold: true, font: 'impact' })
    end
    @levels.append('Back')
    @text_items.append('Back')
    @text_items_imgs.append(Gosu::Image.from_text('Back', LEVELFONTSIZE, { bold: true, font: 'impact' }))
    @maintext = Gosu::Image.from_text('Level Select', MAINFONTSIZE, { bold: true, font: 'impact' })
  end

  def path
    if @menuid.nil?
      nil
    else
      @levels[@menuid]
    end
  end
end
