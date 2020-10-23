require_relative "piece.rb"
require_relative "chess_error.rb"
require_relative "null_piece.rb"

class Board
    def initialize
        @grid = Array.new(8) { Array.new(8, Null_Piece.instance) }
        #setup_game
    end

    def setup_game
        @grid.each_with_index do |row, row_num|
            row.each_with_index do |square, col_num|
                pos = [row_num, col_num]
                if (row_num < 2 || row_num > 5)
                    self[pos] = Piece.new(self, :white, pos)
                end
            end
        end
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
            print row.join(" ") + "\n"
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

end
