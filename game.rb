require_relative 'board.rb'
require_relative 'display.rb'

class Game

    def initialize
        @board = Board.new
        @display = Display.new(@board)
        @players
        @current_player
    end

    def play
        until game_over?
            @display.render
        end
    end

    private

    def notify_players
    end

    def swap_turn!
    end

    def game_over?
    end

end

if __FILE__ == $PROGRAM_NAME
    game = Game.new
    game.play
end