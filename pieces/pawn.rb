require_relative "stepable"
require_relative "piece"
require "byebug"

class Pawn < Piece

    def initialize(board, color, pos)
        super
    end

    def symbol
        :P
    end

    def moves 
        forward_steps + side_attack
    end

    def threatened_positions
        side_attack
    end
    
    private
    def at_start_row?
        start_row_num = @color == :black ? 1 : 6
        start_row_num == @pos[0]
    end
    
    def forward_dir
        return 1 if @color == :black
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
            @board.on_board?(pos) && 
            !@board[pos].empty? && 
            @board[pos].color != @color
        end
    end
    
end