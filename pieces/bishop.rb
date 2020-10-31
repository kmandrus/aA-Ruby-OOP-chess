require_relative "piece"
require_relative "slideable"

class Bishop < Piece
    include Slideable

    def initialize(board, color, pos)
        @points = 3
        super
    end

    def symbol
        if color == :black
            :♝
        else
            :♗
        end
    end

    private
    def move_dirs
        diagonal_dirs
    end

end