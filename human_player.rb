require_relative 'player.rb'

class Human_Player < Player

    def make_move
        @display.render
        result = @display.get_input
        until result
            @display.render
            result = @display.get_input
        end
        result
    end

end