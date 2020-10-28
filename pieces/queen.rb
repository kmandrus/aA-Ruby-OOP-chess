require_relative "slideable"
require_relative "piece"

class Queen < Piece
    include Slideable

    def initialize(board, color, pos)
        super
    end

    def symbol
        :Q
    end

    def dup(new_board)
        Queen.new(new_board, @color, @pos)
    end

    private
    def move_dirs
        horizontal_dirs + diagonal_dirs
    end
    
end