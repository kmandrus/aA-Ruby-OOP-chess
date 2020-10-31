require_relative "stepable"
require_relative "piece"

class Knight < Piece
    MOVE_DIFFS = [
        [2, 1],
        [2, -1],
        [1, 2],
        [1, -2],
        [-2, 1],
        [-2, -1],
        [-1, 2],
        [-1, -2]
    ]

    include Stepable

    def initialize(board, color, pos)
        @points = 3
        super
    end

    def symbol
        if color == :black
            :♞
        else
            :♘
        end
    end

    private
    def move_diffs
        MOVE_DIFFS
    end
    
end