require 'colorize'

class Piece
    attr_reader :color, :points
    attr_accessor :pos, :board

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
        " #{symbol} "
    end
    
    def valid_moves
        moves.select { |move| !move_into_check?(move) } 
    end

    def threatened_positions
        moves
    end

    def moves
        raise "subclass must override"
    end

    def inspect
        "@color = #{@color}, @pos = #{@pos}"
    end

    def opposing_color
        @color == :black ? :white : :black
    end

    def empty?
        false
    end

    def copy_to(new_board)
        copy = dup
        copy.board = new_board
        new_board[pos] = copy
    end

    def ==(other_piece)
        if self.class == other_piece.class && self.color == other_piece.color
            return true
        end
        false
    end

    private
    def valid_move?(pos)
        return false unless @board.on_board?(pos)
        return false if @board[pos].color == @color
        true
    end

    def move_into_check?(end_pos)
        copied_board = @board.dup
        copied_board.move_piece!(@pos, end_pos)
        copied_board.king(@color).in_check?
    end

end