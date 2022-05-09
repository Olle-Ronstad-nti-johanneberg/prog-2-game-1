require 'gosu'

require_relative 'basemenu'
require_relative 'level_menu'
require_relative 'level'
require_relative 'player'
require_relative 'highscore'
require_relative 'pause_menu'
require_relative 'custominput'

# Main class for game
class Main < Gosu::Window
  def initialize
    super(1280, 720)
    self.caption = 'Lunar Game'
    @level = nil
    @levelmenu = LevelMenu.new(self)
    @startmenu = BaseMenu.new(
      self, 'LUNAR GAME', '',
      { 'Level Select' => 'levelMenu', 'Highscore' => 'highscore', 'Settings' => 'settingsMenu', 'Legal' => 'legal', 'Exit' => 'exit' },
      'startMenu'
    )
    @legalmenu = BaseMenu.new(self, 'Leagal', Gosu::LICENSES, { Back: 'startMenu' }, 'Leagal')
    @settingsmenu = BaseMenu.new(self, 'Settings', "Current Gosu version: #{Gosu::VERSION}", { Back: 'startMenu' }, 'settingsMenu')
    @highscoremenu = Highscore.new(self)
    @player = nil
    @state = 'startMenu'
    @pressed = false
    @font = Gosu::Font.new(50, name: 'Comic Sans MS')
    @score = nil
    @current_highscore = @highscore = YAML.load_file('highscore.yaml')
    @pause_menu = nil
  end

  def update
    case @state
    when 'startMenu'
      @startmenu.update
      if enter? && @pressed == false
        @state = @startmenu.new_state
        @pressed = true
      end

    when 'levelMenu'
      @levelmenu.update
      if enter? && !@levelmenu.path.nil? && @pressed == false
        if @levelmenu.path == 'Back'
          @state = 'startMenu'
        else
          @pause_menu = PauseMenu.new(self, 'Game Paused', "Curent level:\n#{@levelmenu.path['name']}\nHighscore:\nnil", { 'Restart' => 'restart', 'Return' => 'level', 'Exit' => 'levelMenu' }, 'Paused')
          @level = Level.new(self, @levelmenu.path)
          @player = Player.new(height, width, @level.ground, @level.data)
          @state = 'level'
        end
        @pressed = true
      end

    when 'highscore'
      @highscoremenu.update_score
      @highscoremenu.update
      if enter? && @pressed == false
        @state = @highscoremenu.new_state
        @pressed = true
      end

    when 'legal'
      @legalmenu.update
      if enter? && @pressed == false
        @state = @legalmenu.new_state
        @pressed = true
      end

    when 'settingsMenu'
      @settingsmenu.update
      if enter? && @pressed == false
        @state = @settingsmenu.new_state
        @pressed = true
      end

    when 'level'
      @player.update
      if (@level.ground.angle(@player.img_x) < @player.angle + 25 && @level.ground.angle(@player.img_x) > @player.angle - 25) && @player.colliding
        @score = 10_000 / (Math.sqrt(@player.vel_x**2 + @player.vel_y**2) + 1)
        if @highscore[@levelmenu.path['name'][-1].to_i - 1]['score'] < @score.round
          @current_highscore[@levelmenu.path['name'][-1].to_i - 1]['score'] = @score.round
          File.open('highscore.yaml', 'w') do |x|
            x.write @current_highscore.to_yaml
          end
          update_score
        end
        @pause_menu = PauseMenu.new(self, 'Landed', "Curent level:\n#{@levelmenu.path['name']}\nScore:\n#{@score.round}\nHighscore:\n#{@highscore[@levelmenu.path['name'][-1].to_i - 1]['score']}", { 'Restart' => 'restart', 'Back' => 'levelMenu' }, 'paused')
        @state = 'paused'

      elsif !((@level.ground.angle(@player.img_x) > @player.angle + 25 && @level.ground.angle(@player.img_x) < @player.angle - 25)) && @player.colliding
        @pause_menu = PauseMenu.new(self, 'Game Over', "Curent level:\n#{@levelmenu.path['name']}\nHighscore:\n#{@highscore[@levelmenu.path['name'][-1].to_i - 1]['score']}", { 'Restart' => 'restart', 'Back' => 'levelMenu' }, 'paused')
        @state = 'paused'
      end
      if Gosu.button_down?(Gosu::KbEscape)
        @state = 'paused'
      end

    when 'exit'
      close

    when 'paused'
      @pause_menu.update
      if enter? && @pressed == false
        if @pause_menu.new_state == 'restart'
          @pause_menu = PauseMenu.new(self, 'Game Paused', "Curent level:\n#{@levelmenu.path['name']}\nHighscore:\nnil", { 'Restart' => 'restart', 'Return' => 'level', 'Exit' => 'levelMenu' }, 'Paused')
          @level = Level.new(self, @levelmenu.path)
          @player = Player.new(height, width, @level.ground, @level.data)
          @state = 'level'
        else
          @state = @pause_menu.new_state
        end
        @pressed = true
      end
    else
      raise "state #{@state} is unknown"
    end

    if !enter?
      @pressed = false
    end
  end

  def update_score
    @current_highscore = @highscore = YAML.load_file('highscore.yaml')
  end

  def draw
    case @state
    when 'startMenu'
      @startmenu.draw
    when 'levelMenu'
      @levelmenu.draw
    when 'highscore'
      @highscoremenu.draw
    when 'legal'
      @legalmenu.draw
    when 'settingsMenu'
      @settingsmenu.draw
    when 'level'
      @level.draw
      @player.draw
      @font.draw_text(@levelmenu.path['name'], 0, 0, 0)
    when 'paused'
      @level.draw
      @player.draw
      @pause_menu.draw
    end
  end
end

Main.new.show
