class Player
    attr_accessor :color, :display

    def initialize(color, display)
        @color = color
        @display = display
    end

    def make_move(board)
        raise "subclass must override"
    end
    
end