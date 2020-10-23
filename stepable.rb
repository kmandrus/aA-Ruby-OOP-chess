module Stepable
    def moves
        valid_moves = []
        move_diffs.each do |diff|
            x, y = @pos
            dx, dy = diff
            pos = [x + dx, y + dy]
            valid_moves << pos if valid_move?(pos)
        end
    end

    private
    def move_diffs
        #mixin class must override
    end
end

