require_relative "slideable"
require_relative "piece"

class Rook < Piece
    include Slideable

    def initialize(board, color, pos)
        super
    end

    def symbol
        if color == :black
            :♜
        else
            :♖
        end
    end

    private
    def move_dirs
        horizontal_dirs
    end
    
end