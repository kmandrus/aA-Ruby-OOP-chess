require "io/console"

class Cursor
    attr_reader :board, :cursor_pos, :selected

    KEYMAP = {
        " " => :space,
        "h" => :left,
        "j" => :down,
        "k" => :up,
        "l" => :right,
        "w" => :up,
        "a" => :left,
        "s" => :down,
        "d" => :right,
        "\t" => :tab,
        "\r" => :return,
        "\n" => :newline,
        "\e" => :escape,
        "\e[A" => :up,
        "\e[B" => :down,
        "\e[C" => :right,
        "\e[D" => :left,
        "\177" => :backspace,
        "\004" => :delete,
        "\u0003" => :ctrl_c,
    }

    MOVES = {
        left: [0, -1],
        right: [0, 1],
        up: [-1, 0],
        down: [1, 0]
    }

    def initialize(board)
        @board = board
        @cursor_pos = [0,0]
        @selected = nil
    end

    def get_input
        display_instructions
        key = KEYMAP[read_char]
        handle_key(key)
    end

    def toggle_selected
        @selected = nil if @selected
    end

    private

    def handle_key(key)
        case key
        when :return
            if @selected
                start_pos, end_pos = selected, cursor_pos
                toggle_selected
                return [start_pos, end_pos]
            else
                @selected = cursor_pos unless @board[cursor_pos].empty?
            end
        when :escape
            toggle_selected
        when :up
            update_pos(MOVES[:up])
        when :down
            update_pos(MOVES[:down])
        when :right
            update_pos(MOVES[:right])
        when :left
            update_pos(MOVES[:left])
        when :ctrl_c 
            exit 0
        end
        return false
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

    def display_instructions
        if selected == nil
            puts "select a piece by pressing return"
        else
            puts "move the selected piece by pressing return"
            puts "clear your selection by pressing esc"
        end
    end

end