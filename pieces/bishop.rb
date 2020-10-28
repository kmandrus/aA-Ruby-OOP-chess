require_relative "piece"
require_relative "slideable"

class Bishop < Piece
    include Slideable

    def initialize(board, color, pos)
        super
    end

    def symbol
        :B
    end

    def dup(new_board)
        Bishop.new(new_board, @color, @pos)
    end

    private
    def move_dirs
        diagonal_dirs
    end

end