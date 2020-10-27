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

    private
    def move_dirs
        diagonal_dirs
    end

end