Dir[__dir__ + '/pieces/*'].each { |file| require file }
require_relative 'chess_error.rb'
require "colorize"

class Board
    attr_reader :rows
    def initialize(empty_board=false)
        @rows = Array.new(8) { Array.new(8, Null_Piece.instance) }
        setup_grid unless empty_board
    end

    def move_piece(start_pos, end_pos)
        piece = self[start_pos]
        #raise exception if there is no piece to move at start_pos
        if piece.is_a?(Null_Piece)
            raise ChessError.new("no piece at start position")
        end
        #raise exception if the piece cannot move to end_pos
        unless piece.moves.include?(end_pos)
            raise ChessError.new("cannot move to end position")
        end
        if piece.move_into_check?(end_pos)
            raise ChessError.new, "cannot move into check"
        end

        self[start_pos] = Null_Piece.instance
        self[end_pos] = piece
        piece.pos = end_pos
    end

    def dup
        copied_board = Board.new(true)
        @rows.each_with_index do |row, y|
            row.each_with_index do |square, x|
                square.dup(copied_board) unless square.empty?
            end
        end
        copied_board
    end

    def pieces(color)
        rows.flatten.select { |piece| piece.color == color }
    end

    def king(color)
        rows.flatten.each do |piece| 
            if piece.color == color && piece.is_a?(King)
                return piece
            end
        end
    end

    def debug_render
        rows.each do |row| 
            print row.join("") + "\n"
        end
        puts
    end

    def [](pos)
        row, col = pos
        rows[row][col]
    end
    def []=(pos, piece)
        row, col = pos
        rows[row][col] = piece
    end

    def on_board?(pos)
        pos.all? { |val| val >= 0 && val < 8 }
    end
    
    private
    def setup_grid
        %i(black white).each do |color|
            setup_back_row(color)
            setup_pawns(color)
        end
    end

    def setup_back_row(color)
        piece_classes = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
        y = color == :black ? 0 : 7
        piece_classes.each_with_index do |piece_class, x|
            piece_class.new(self, color, [y, x])
        end
    end
    def setup_pawns(color)
        y = color == :black ? 1 : 6
        (0..7).each do |x|
            Pawn.new(self, color, [y, x])
        end
    end
end
