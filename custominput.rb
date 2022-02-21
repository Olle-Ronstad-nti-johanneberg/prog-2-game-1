require 'gosu'


def up?()
    Gosu.button_down?(Gosu::KB_DOWN)||Gosu.button_down?(Gosu::KB_S)
end

def down?()
    Gosu.button_down?(Gosu::KB_UP)||Gosu.button_down?(Gosu::KB_W)
end

def right?()
    Gosu.button_down?(Gosu::KB_RIGHT)||Gosu.button_down?(Gosu::KB_D)
end

def left?()
    Gosu.button_down?(Gosu::KB_A)||Gosu.button_down?(Gosu::KB_LEFT)
end

def enter?()
    (button_down?(Gosu::MS_LEFT))||button_down?(Gosu::KB_RETURN)||(button_down?(Gosu::KB_SPACE))
end