require "byebug"

module Slideable
    HORIZONTAL_DIRS = [ [1,0], [-1,0], [0,1], [0,-1] ]
    DIAGONAL_DIRS = [ [1,1], [-1,-1], [-1,1], [1,-1] ]
    
    def horizontal_dirs
        HORIZONTAL_DIRS
    end
    def diagonal_dirs
        DIAGONAL_DIRS
    end

    def moves
        moves_array = []
        move_dirs.each do |diff|
            moves_array.concat(grow_unblocked_moves_in_dir(*diff))
        end
        moves_array
    end

    private
    def move_dirs
        #mixin class must override 
    end

    def grow_unblocked_moves_in_dir(dx, dy)
        y, x = @pos
        moves = []
        new_pos = [y + dy, x + dx]
        while valid_move?(new_pos)
            moves << new_pos
            break unless @board[new_pos].is_a?(Null_Piece) 
            y, x = new_pos
            new_pos = [y + dy, x + dx]
        end
        moves
    end

end