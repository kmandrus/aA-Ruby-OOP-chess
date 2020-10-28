require 'colorize'

class Piece
    attr_reader :color
    attr_accessor :pos

    def initialize(board, color, pos)
        @board = board
        @color = color
        @pos = pos
        @board[@pos] = self
    end

    def symbol
        :Z
    end

    def to_s
        " #{symbol} ".colorize(:color => color, :background => :blue)
    end

    def inspect
        "@color = #{@color}, @pos = #{@pos}"
    end

    def valid_move?(pos)
        return false unless @board.on_board?(pos)
        return false if @board[pos].color == @color
        true
    end

    def move_into_check?(end_pos)
        #find your color's king
        #determine if the new board state will put the king in check
        #loop over all the enemy pieces and check if the King is in one of their threatened squares
        #aA examines the new board state by duplicating the board... 
    end

    def empty?
        false
    end

    def dup(new_board)
        Self.new(new_board, @color, @pos)
    end

end