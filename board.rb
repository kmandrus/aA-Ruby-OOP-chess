require_relative "piece.rb"
require_relative "chess_error.rb"
require_relative "null_piece.rb"

class Board
    def initialize
        @grid = Array.new(8) { Array.new(8) }
        setup_game
    end

    def setup_game
        @grid.each_with_index do |row, row_num|
            row.each_with_index do |square, col_num|
                if (row_num < 2 || row_num > 5)
                    @grid[row_num][col_num] = Piece.new 
                end
            end
        end
                
    end

    def move_piece(start_pos, end_pos)
        #raise exception if there is no piece to move at start_pos
        if self[start_pos].is_a?(Null_Piece) || self[start_pos] == nil
            raise ChessError.new("no piece at start position")
        end
        #raise exception if the piece cannot move to end_pos
        if self[end_pos].is_a?(Null_Piece) || self[end_pos] == nil
            raise ChessError.new("cannot move to end position")
        end

        piece = self[start_pos]
        self[start_pos] = nil
        self[end_pos] = piece

    end

    def debug_render
        rows.each { |row| p row }
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
end

b = Board.new
b.debug_render
b.move_piece([0,0], [3,1])
b.debug_render
b.move_piece([3,1], [3,2]) #should throw an error
