require "io/console"

class Cursor
    attr_accessor :board, :cursor_pos, :selected

    def initialize(board)
        @board = board
        @cursor_pos = [0,0]
        @selected = nil
    end

    def get_input
        if selected == nil
            puts "select a piece by pressing return"
        else
            puts "move the piece by pressing spacebar"
        end
        handle_key(read_char)
    end

    def toggle_selected
    end

    private

    def handle_key(key)
        square = @board[cursor_pos]

        case key
        when "\r" #RETURN
            @selected = square unless square.empty?
        when " " #SPACE BAR
            #move selected piece
            if @selected
                @board.move_piece(@selected.pos, @cursor_pos)
                @selected = nil
            end
        when "\e" #ESCAPE
            #quit game
            exit 0
        when "s"
            #save game
        when "\e[A" #UP ARROW
            update_pos([-1, 0])
        when "\e[B" #DOWN ARROW
            update_pos([1, 0])
        when "\e[C" #RIGHT ARROW
            update_pos([0, 1])
        when "\e[D" #LEFT ARROW
            update_pos([0, -1])
        when "\u0003" #CONTROL C
            exit 0
        end
    end
    def read_char
        STDIN.echo = false
        STDIN.raw!
    
        input = STDIN.getc.chr
        if input == "\e" then
            input << STDIN.read_nonblock(3) rescue nil
            input << STDIN.read_nonblock(2) rescue nil
        end
        ensure
        STDIN.echo = true
        STDIN.cooked!
    
        return input
    end

    def update_pos(diff)
        y, x = @cursor_pos
        dy, dx = diff
        new_pos = [y + dy, x + dx]
        @cursor_pos = new_pos if @board.on_board?(new_pos)
    end

end