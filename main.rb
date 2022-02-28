require 'gosu'

require_relative 'basemenu.rb'
require_relative 'levelMenu.rb'
require_relative 'Level.rb'
require_relative 'player.rb'
require_relative 'highscore.rb'
require_relative 'pauseMenu.rb'
require_relative 'custominput.rb'

class Main < Gosu::Window
    def initialize
        super(1280, 720)
        self.caption = "Lunar Game"
        @level = nil
        @levelmenu = LevelMenu.new(self)
        @startmenu = BaseMenu.new(self,"LUNAR GAME", "",
            {"Level Select"=>"levelMenu","Highscore"=>"highscore","Settings"=>"settingsMenu","Legal"=>"legal","Exit"=>"exit"},
            "startMenu")
        @legalmenu = BaseMenu.new(self,"Leagal",Gosu::LICENSES,{Back:"startMenu"},"Leagal")
        @settingsmenu = BaseMenu.new(self,"Settings","SIKE! Here is current Gosu version: #{Gosu::VERSION}\n\n If you want settings, fight me! ( •_•)>⌐■-■",{Back:"startMenu"},"settingsMenu")
        @highscoremenu = Highscore.new(self)
        @player = nil
        @state = "startMenu"
        @pressed = false
        @font = Gosu::Font.new(50, name: "Comic Sans MS")
        @score = nil
        @currentHighscore = @highscore = YAML.load_file("highscore.yaml")
        @pauseMenu = nil
    end

    def update
        case @state
        when "startMenu"
            @startmenu.update
            if enter? && @pressed == false
                @state = @startmenu.newState
                @pressed = true
            end

        when "levelMenu"
            @levelmenu.update
            if enter? && !@levelmenu.path.nil? && @pressed == false
                if @levelmenu.path == "Back"
                    @state = "startMenu"
                else
                    @pauseMenu = PauseMenu.new(self,"Game Paused","Curent level:\n#{@levelmenu.path["name"]}\nHighscore:\n#{"nil"}",{"Restart"=>"restart","Return"=>"level","Exit"=>"levelMenu"},"Paused")
                    @level = Level.new(self, @levelmenu.path)
                    @player = Player.new(self.height, self.width, @level.ground, @level.data)
                    @state = "level"
                end
                @pressed = true
            end
        
        when "highscore"
            @highscoremenu.updateScore()
            @highscoremenu.update
            if enter? && @pressed == false
                @state = @highscoremenu.newState
                @pressed = true
            end

            
        when "legal"
            @legalmenu.update
            if enter? && @pressed == false
                @state = @legalmenu.newState
                @pressed = true
            end

        when "settingsMenu"
            @settingsmenu.update
            if enter? && @pressed == false
                @state = @settingsmenu.newState
                @pressed = true
            end

        when "level"
            @player.update
            if (@level.ground.angle(@player.img_x) < @player.angle+25 && @level.ground.angle(@player.img_x) > @player.angle-25) && @player.colliding
                @score = 10000/(Math.sqrt(@player.vel_x**2 + @player.vel_y**2) + 1)
                if @highscore[@levelmenu.path["name"][-1].to_i-1]["score"] < @score.round
                    @currentHighscore[@levelmenu.path["name"][-1].to_i-1]["score"] = @score.round
                    f = File.open('highscore.yaml', 'w') do |x| 
                        x.write @currentHighscore.to_yaml
                    end
                    updateScore()
                end
                @pauseMenu = PauseMenu.new(self,"Landed","Curent level:\n#{@levelmenu.path["name"]}\nScore:\n#{@score.round()}\nHighscore:\n#{@highscore[@levelmenu.path["name"][-1].to_i-1]["score"]}",{"Restart"=>"restart","Back"=>"levelMenu"},"paused")
                @state = "paused"

            elsif !((@level.ground.angle(@player.img_x) > @player.angle+25 && @level.ground.angle(@player.img_x) < @player.angle-25)) && @player.colliding
                @pauseMenu = PauseMenu.new(self,"Game Over","Curent level:\n#{@levelmenu.path["name"]}\nHighscore:\n#{@highscore[@levelmenu.path["name"][-1].to_i-1]["score"]}",{"Restart"=>"restart","Back"=>"levelMenu"},"paused")
                @state = "paused"

            end
            if Gosu.button_down?(Gosu::KbEscape)
                @state ="paused"
            end

        when "exit"
            close

        when "paused"
            @pauseMenu.update
            if enter? && @pressed == false
                if @pauseMenu.newState == "restart"
                    @pauseMenu = PauseMenu.new(self,"Game Paused","Curent level:\n#{@levelmenu.path["name"]}\nHighscore:\n#{"nil"}",{"Restart"=>"restart","Return"=>"level","Exit"=>"levelMenu"},"Paused")
                    @level = Level.new(self, @levelmenu.path)
                    @player = Player.new(self.height, self.width, @level.ground, @level.data)
                    @state = "level"
                else
                    @state = @pauseMenu.newState
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

    def updateScore
        @currentHighscore = @highscore = YAML.load_file("highscore.yaml")
    end

    def draw
        case @state
        when "startMenu"
           @startmenu.draw
        when "levelMenu"
            @levelmenu.draw
        when "highscore"
            @highscoremenu.draw
        when "legal"
            @legalmenu.draw
        when "settingsMenu"
            @settingsmenu.draw
        when "level"
            @level.draw
            @player.draw
            @font.draw_text(@levelmenu.path["name"], 0, 0, 0)
        when "paused"
            @level.draw
            @player.draw
            @pauseMenu.draw
        end

    end
end

Main.new.show