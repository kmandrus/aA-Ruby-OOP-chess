require_relative 'player.rb'

class Human_Player < Player

    def make_move(board)
        @display.render
        turn_message
        check_warning if board.king(color).in_check?
        result = @display.get_input
        until result
            @display.render
            result = @display.get_input
        end
        result
    end

    private
    def check_warning
        puts "your king is in check"
    end
    def turn_message
        puts "#{color}'s turn'"
    end
end