require 'gosu'
require_relative 'basemenu'

# Highscore menu
class Highscore < BaseMenu
  def initialize(window)
    super(window, '', '', {}, 'highscore')

    @data = YAML.load_file('highscore.yaml')
    @extra_text_img = @data.each.map do |key|
      "#{key['name']} : #{key['score']}"
    end.join("\n")
    @extra_text_img = Gosu::Image.from_text(@extra_text_img, LEVELFONTSIZE, { bold: true, font: 'impact' })
    @states = ['startMenu']
    @text_items = ['Back']
    @text_items_imgs = [Gosu::Image.from_text('Back', LEVELFONTSIZE, { bold: true, font: 'impact' })]
    @maintext = Gosu::Image.from_text('Highscore', MAINFONTSIZE, { bold: true, font: 'impact' })
  end

  def new_state
    if @menuid.nil?
      'highscore'
    else
      @states[@menuid]
    end
  end

  def update_score
    @data = YAML.load_file('highscore.yaml')
    @extra_text_img = @data.each.map do |key|
      "#{key['name']} : #{key['score']}"
    end.join("\n")
    @extra_text_img = Gosu::Image.from_text(@extra_text_img, LEVELFONTSIZE, { bold: true, font: 'impact' })
  end
end
