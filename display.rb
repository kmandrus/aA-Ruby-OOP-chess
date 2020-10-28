require_relative 'cursor.rb'
require_relative 'board.rb'
require'colorize'

class Display
    
    def initialize(board)
        @board = board
        @cursor = Cursor.new(@board)
    
    end

    def render
        system("clear")
        @board.rows.each_with_index do |row, y| 
            row.each_with_index do |square, x|
                print(print_val(square, [y, x]))
            end
            puts
        end
        puts
        @cursor.get_input
    end

    private

    def print_val(square, pos)
        return square.to_s.on_yellow if pos == @cursor.cursor_pos
        square.to_s
    end

end