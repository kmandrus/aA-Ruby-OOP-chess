class Piece
    attr_reader :color
    attr_accessor :pos

    def initialize(board, color, pos)
        @board = board
        @color = color
        @pos = pos
    end

    def to_s
        "#P#"
    end

    def inspect
        "@color = #{@color}, @pos = #{@pos}"
    end

    def valid_move?(pos)
        return false unless @board.on_board?(pos)
        return false if @board[pos].color == @color
        true
    end

end