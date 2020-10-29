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
    end

    def get_input
        @cursor.get_input
    end

    private

    def print_val(square, pos)
        if pos == @cursor.cursor_pos || pos == @cursor.selected
            square.to_s.on_yellow
        else
            square.to_s.colorize(:background => square_color(pos))
        end
    end

    def square_color(pos)
        y, x = pos
        if y.even?
            x.even? ? :blue : :black
        else
            x.even? ? :black : :blue
        end
    end
end