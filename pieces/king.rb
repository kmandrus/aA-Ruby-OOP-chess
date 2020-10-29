require_relative "stepable"
require_relative "piece"

class King < Piece
    MOVE_DIFFS = [
        [0, 1],
        [1, 1],
        [1, 0],
        [1, -1],
        [0, -1],
        [-1, -1],
        [-1, 0],
        [-1, 1]
    ]

    include Stepable

    def initialize(board, color, pos)
        super
    end

    def symbol
        :K
    end

    def in_check?
        @board.pieces(opposing_color).any? do |piece|
            piece.threatened_positions.include?(@pos)
        end
    end

    private
    def move_diffs
        MOVE_DIFFS
    end
    
end