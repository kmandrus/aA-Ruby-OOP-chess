require_relative "chess_error.rb"
require_relative "./pieces/null_piece.rb"
require_relative './pieces/rook.rb'
require_relative './pieces/bishop.rb'
require_relative './pieces/queen.rb'
require_relative './pieces/king.rb'
require_relative './pieces/pawn.rb'
require_relative './pieces/knight.rb'
require "colorize"

class Board
    def initialize
        @grid = Array.new(8) { Array.new(8, Null_Piece.instance) }
        setup_game
    end

    def setup_game
        setup_pawns
        setup_rooks
        setup_knights
        setup_bishops
        setup_queens
        setup_kings
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

        self[start_pos] = Null_Piece.instance
        self[end_pos] = piece
        piece.pos = end_pos
    end

    def debug_render
        rows.each do |row| 
            print row.join("") + "\n"
        end
        puts
    end

    def rows
        @grid
    end

    def [](pos)
        row, col = pos
        @grid[row][col]
    end
    def []=(pos, piece)
        row, col = pos
        @grid[row][col] = piece
    end

    def on_board?(pos)
        row, col = pos
        if (
            row < 8 && row >= 0 &&
            col < 8 && col >= 0 )
            return true
        end
        false
    end
    
    private
    def setup_rooks
        positions = n_r_b_positions(0)
        positions.each do |pos|
            self[pos] = Rook.new(self, setup_color(pos), pos)
        end
    end
    def setup_knights
        positions = n_r_b_positions(1)
        positions.each do |pos|
            self[pos] = Knight.new(self, setup_color(pos), pos)
        end
    end
    def setup_bishops
        positions = n_r_b_positions(2)
        positions.each do |pos|
            self[pos] = Bishop.new(self, setup_color(pos), pos)
        end
    end
    def setup_queens
        positions = [ [0, 3], [7, 3] ]
        positions.each do |pos|
            self[pos] = Queen.new(self, setup_color(pos), pos)
        end
    end
    def setup_kings
        positions = [ [0, 4], [7, 4] ]
        positions.each do |pos|
            self[pos] = King.new(self, setup_color(pos), pos)
        end
    end
    def setup_pawns
        (0..7).each do |col|
            pos_1 = [1, col]
            pos_2 = [6, col]
            self[pos_1] = Pawn.new(self, setup_color(pos_1), pos_1)
            self[pos_2] = Pawn.new(self, setup_color(pos_2), pos_2)
        end
    end
    def n_r_b_positions(col)
        [ [0, col], [0, 7 - col], [7, col], [7, 7 - col] ]
    end
    def setup_color(pos)
        row_num = pos[0]
        return :black if row_num < 3
        :white
    end 

end
