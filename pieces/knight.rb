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
        super
    end

    def symbol
        :N
    end

    def dup(new_board)
        Knight.new(new_board, @color, @pos)
    end

    private
    def move_diffs
        MOVE_DIFFS
    end
    
end