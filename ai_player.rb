require_relative 'player.rb'

class AI_Player < Player
    
    def initialize(color, display)
        super
    end

    def make_move(board)
        random_move(board)
    end

    private
    def random_move(board)
        pieces = board.pieces(color)
        pieces.shuffle.each do |piece|
            unless piece.valid_moves.empty?
                end_pos = piece.valid_moves.shuffle.last
                return [piece.pos, end_pos]
            end
        end
        raise "unable to find any valid moves for AI player"
    end
    
end