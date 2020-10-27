require_relative "stepable"
require_relative "piece"

class Pawn < Piece
    MOVE_DIFFS = [
        [0, 1],
        [1, 1],
        [1, 0],
        [1, -1],
        [0, -1],
        [-1, -1],
        [-1, 0],
        [-1, 1]
    ]

    def initialize(board, color, pos)
        @start_row = pos[0]
        super
    end

    def symbol
        :P
    end

    def moves 
        forward_steps + side_attack
    end
    
    private
    def at_start_row?
        @pos[0] == @start_row
    end
    
    def forward_dir
        return 1 if @start_row == 1
         -1
    end

    def forward_steps
        y, x = @pos
        steps = []
        one_step = [y + forward_dir, x]
        two_steps = [y + (forward_dir * 2), x]

        if @board[one_step].empty?
            steps << one_step
            if @board[two_steps].empty? && at_start_row?
                steps << two_steps
            end
        end
        steps
    end

    def side_attack
        y, x = @pos
        attack_diffs = [ 
            [forward_dir, 1], 
            [forward_dir, -1] 
        ]
        threatened_positions = attack_diffs.map do |diff|
            dy, dx = diff
            [y + dy, x + dx]
        end
        threatened_positions.select do |pos|
            !@board[pos].empty? && @board[pos].color != @color
        end
    end
    
end