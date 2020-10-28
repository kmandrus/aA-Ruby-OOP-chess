module Stepable
    def moves
        valid_moves = []
        move_diffs.each do |diff|
            y, x = @pos
            dy, dx = diff
            pos = [y + dy, x + dx]
            valid_moves << pos if valid_move?(pos)
        end
        valid_moves
    end

    private
    def move_diffs
        #mixin class must override
    end
end

