require_relative "slideable"
require_relative "piece"

class Queen < Piece
    include Slideable

    def initialize(board, color, pos)
        @points = 9
        super
    end

    def symbol
        if color == :black
            :♛
        else
            :♕
        end
    end

    private
    def move_dirs
        horizontal_dirs + diagonal_dirs
    end
    
end