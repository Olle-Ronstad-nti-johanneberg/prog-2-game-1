require_relative 'custominput'

TOPSPACING = 50
MAINFONTSIZE = 75
LEVELFONTSIZE = 20
LEVELFONTTEXTSPACING = 5
MAINFONTSPACING = 2

# Generate menu layout
class BaseMenu
  def initialize(window, maintext, extra_text, text_state_hash, selfstate)
    @window = window
    @selfstate = selfstate

    @states = []
    @text_items_imgs = []

    text_state_hash.each do |key, value|
      @text_items_imgs.append(Gosu::Image.from_text(key.to_s, LEVELFONTSIZE, { bold: true, font: 'impact' }))
      @states.append(value)
    end

    @maintext = Gosu::Image.from_text(maintext, MAINFONTSIZE, { bold: true, font: 'impact' })
    @extra_text_img = Gosu::Image.from_text(extra_text, LEVELFONTSIZE, { bold: true, font: 'impact', align: :center })
    @left_arrow = Gosu::Image.from_text('<', LEVELFONTSIZE, { bold: true, font: 'impact' })
    @right_arrow = Gosu::Image.from_text('>', LEVELFONTSIZE, { bold: true, font: 'impact' })
    @copyright = Gosu::Image.from_text('© Ronstad, Olle & Söderborg, Viktor', LEVELFONTSIZE, { bold: true, font: 'impact' })

    @menuid = nil
    @last_x = 0
    @last_y = 0
    @pressed = false
  end

  def draw
    @maintext.draw((@window.width - @maintext.width) * 0.5, LEVELFONTSIZE + LEVELFONTTEXTSPACING + TOPSPACING)
    @extra_text_img.draw((@window.width - @extra_text_img.width) * 0.5, MAINFONTSIZE * MAINFONTSPACING + TOPSPACING - 20)
    @text_items_imgs.each_with_index do |text, i|
      text.draw((@window.width - text.width) * 0.5, i * (LEVELFONTSIZE + LEVELFONTTEXTSPACING) + MAINFONTSIZE * MAINFONTSPACING + TOPSPACING + @extra_text_img.height)
    end
    if movedmouse?
      hovering_id = id_hovering_over
      @menuid = id_hovering_over
    else
      hovering_id = @menuid
    end
    unless hovering_id.nil?
      @left_arrow.draw((@window.width + @text_items_imgs[hovering_id].width) * 0.5, hovering_id * (LEVELFONTSIZE + LEVELFONTTEXTSPACING) + MAINFONTSIZE * MAINFONTSPACING + TOPSPACING + @extra_text_img.height)
      @right_arrow.draw((@window.width - @text_items_imgs[hovering_id].width) * 0.5 - @right_arrow.width, hovering_id * (LEVELFONTSIZE + LEVELFONTTEXTSPACING) + MAINFONTSIZE * MAINFONTSPACING + TOPSPACING + @extra_text_img.height)
    end
    @copyright.draw((@window.width - @copyright.width) * 0.5, @window.height - 50)
  end

  def update
    if down?
      unless @pressed
        menuselectdown
        @pressed = true
      end
    end
    if up?
      unless @pressed
        menuselectup
        @pressed = true
      end
    end
    if !up? && !down?
      @pressed = false
    end
  end

  def new_state
    if @menuid.nil?
      @selfstate
    else
      @states[@menuid]
    end
  end

  private

  def menuselectup
    if @menuid.nil?
      @menuid = 0
    elsif @menuid + 1 > @text_items_imgs.length - 1
      @menuid = nil
    else
      @menuid += 1
    end
  end

  def menuselectdown
    if @menuid.nil?
      @menuid = @text_items_imgs.length - 1
    elsif (@menuid - 1).negative?
      @menuid = nil
    else
      @menuid -= 1
    end
  end

  def movedmouse?
    moved = (@last_x - 1 > @window.mouse_x || @last_x + 1 < @window.mouse_x) || (@last_y - 1 > @window.mouse_y || @last_y + 1 < @window.mouse_y)
    @last_x = @window.mouse_x
    @last_y = @window.mouse_y
    moved
  end

  def id_hovering_over
    if @window.mouse_x > @window.width / 4 && @window.mouse_x < @window.width / 4 * 3
      tmp = ((@window.mouse_y - MAINFONTSIZE * MAINFONTSPACING - TOPSPACING - @extra_text_img.height) / (LEVELFONTSIZE + LEVELFONTTEXTSPACING)).floor
      if tmp.negative? || tmp > @text_items_imgs.length - 1
        nil
      else
        tmp
      end
    end
  end
end
