TOPSPACING = 50
MAINFONTSIZE = 75
LEVELFONTSIZE = 20
LEVELFONTTEXTSPACING = 5
MAINFONTSPACING = 2

class BaseMenu
    def initialize(window,maintext,extraText,textStateHash,selfstate)
        @window = window
        @selfstate = selfstate

        @states = []
        @textItemsImgs = []

        textStateHash.each do |key, value|
            @textItemsImgs.append(Gosu::Image.from_text(key.to_s,LEVELFONTSIZE, {bold: true, font:"impact"}))
            @states.append(value)
        end

        @maintext = Gosu::Image.from_text(maintext,MAINFONTSIZE, {bold: true, font: "impact"})
        @extratextImg = Gosu::Image.from_text(extraText,LEVELFONTSIZE, {bold: true, font: "impact"})
        @leftArrow = Gosu::Image.from_text("<",LEVELFONTSIZE, {bold: true, font: "impact"})
        @rightArrow = Gosu::Image.from_text(">",LEVELFONTSIZE, {bold: true, font: "impact"})
        @copyright = Gosu::Image.from_text("© Ronstad, Olle & Söderborg, Viktor",LEVELFONTSIZE, {bold: true, font: "impact"})

        @menuid = nil
        @last_x = 0
        @last_y = 0
        @pressed = false
    end

    def draw
        @maintext.draw((@window.width-@maintext.width)*0.5,LEVELFONTSIZE+LEVELFONTTEXTSPACING+TOPSPACING)
        @extratextImg.draw((@window.width-@extratextImg.width)*0.5,MAINFONTSIZE*MAINFONTSPACING+TOPSPACING-20)
        @textItemsImgs.each_with_index do |text, i|
            text.draw((@window.width-text.width)*0.5,i*(LEVELFONTSIZE+LEVELFONTTEXTSPACING)+MAINFONTSIZE*MAINFONTSPACING+TOPSPACING+@extratextImg.height)
        end
        if movedmouse?
            hoveringID = idHoveringOver()
            @menuid = idHoveringOver()
        else
            hoveringID = @menuid
        end
        if !hoveringID.nil?
            @leftArrow.draw((@window.width+@textItemsImgs[hoveringID].width)*0.5,hoveringID*(LEVELFONTSIZE+LEVELFONTTEXTSPACING)+MAINFONTSIZE*MAINFONTSPACING+TOPSPACING+@extratextImg.height)
            @rightArrow.draw((@window.width-@textItemsImgs[hoveringID].width)*0.5-@rightArrow.width,hoveringID*(LEVELFONTSIZE+LEVELFONTTEXTSPACING)+MAINFONTSIZE*MAINFONTSPACING+TOPSPACING+@extratextImg.height)
        end
        @copyright.draw((@window.width-@copyright.width)*0.5,@window.height-50)
    end

    def update
        if Gosu.button_down?(Gosu::KB_DOWN)||Gosu.button_down?(Gosu::KB_S)
            if !@pressed
                menuselectdown()
                @pressed = true
            end
        end 
        if Gosu.button_down?(Gosu::KB_UP)||Gosu.button_down?(Gosu::KB_W)
            if !@pressed
                menuselectup()
                @pressed = true
            end
        end
        
        if !(Gosu.button_down?(Gosu::KB_UP)||Gosu.button_down?(Gosu::KB_W)||Gosu.button_down?(Gosu::KB_DOWN)||Gosu.button_down?(Gosu::KB_S))
            @pressed = false
        end
    end

    def newState
        if @menuid.nil?
            return @selfstate
        else
            return @states[@menuid]
        end
    end
    

    private
    
    def menuselectdown()
        if @menuid.nil?
            @menuid = 0
        else
            if @menuid +1 > @textItemsImgs.length-1
                @menuid = nil
            else
                @menuid +=1
            end
        end
    end

    def menuselectup()
        if @menuid.nil?
            @menuid = @textItemsImgs.length-1
        else
            if @menuid -1 < 0
                @menuid = nil
            else
                @menuid -= 1
            end
        end
    end

    def movedmouse?
        moved = (@last_x-1 > @window.mouse_x || @last_x+1 < @window.mouse_x)||(@last_y-1 > @window.mouse_y || @last_y+1 < @window.mouse_y)
        @last_x = @window.mouse_x
        @last_y = @window.mouse_y
        return moved
    end

    def idHoveringOver
        if @window.mouse_x > @window.width/4 && @window.mouse_x < @window.width/4*3
            tmp = ((@window.mouse_y-MAINFONTSIZE*MAINFONTSPACING-TOPSPACING-@extratextImg.height)/(LEVELFONTSIZE+LEVELFONTTEXTSPACING)).floor
            if tmp < 0 || tmp > @textItemsImgs.length-1
                return nil
            else
                return tmp
            end
        end
    end
end