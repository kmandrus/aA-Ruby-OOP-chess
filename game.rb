require_relative 'board.rb'
require_relative 'display.rb'
require_relative 'human_player.rb'

class Game

    def initialize
        @board = Board.new
        @display = Display.new(@board)
        @players = {
            :black => Human_Player.new(:black, @display),
            :white => Human_Player.new(:white, @display)
        }
        @current_player = @players[:white]
    end

    def play
        until game_over?
            @display.render
            puts "#{@current_player.color}'s turn'"
            sleep(1)
            move = @current_player.make_move
            process_human_move(move)
        end    
        
    end

    private

    def notify_players
    end

    def swap_turn!
        if @current_player == @players[:white]
            @current_player = @players[:black]
        else
            @current_player = @players[:white]
        end
    end

    def game_over?
        @board.checkmate?(@current_player.color)
    end

    def process_human_move(move)
        if move
            begin
                selected_piece = @board[move[0]]
                unless selected_piece.color == @current_player.color
                    raise ChessError, "cannot move a piece of the opposing color"
                end 
                @board.move_piece(*move)
                swap_turn!
            rescue ChessError => e
                puts e.message
                sleep(1)
            end
        end
    end

    def game_over_message
        puts "checkmate!"
        puts "#{@current_player.color} loses"
    end

end

if __FILE__ == $PROGRAM_NAME
    game = Game.new
    game.play
end