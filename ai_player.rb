require_relative 'player.rb'
require_relative 'chess_node.rb'
require_relative 'board.rb'
require_relative 'logger.rb'

class AI_Player < Player
    
    def initialize(color, display)
        @root = nil
        super
    end

    def make_move(board)
        bfs_move(board, 5)
    end

    private
    def random_move(board)
        pieces = board.pieces(color)
        pieces.shuffle.each do |piece|
            unless piece.valid_moves.empty?
                end_pos = piece.valid_moves.shuffle.last
                return [piece.pos, end_pos]
            end
        end
        raise "unable to find any valid moves for AI player"
    end

    def bfs_move(board, max_depth)
        @root = @root.prune_tree(board) unless @root == nil
        if @root == nil
            @root = Chess_Node.new(board.dup, color, color, 1) 
        end
        @root.grow_tree(1, max_depth)
        b_node = best_node(@root.children)
        b_node.previous_move
    end

    private 
    def best_node(nodes)
        nodes_copy = nodes.dup
        best_nodes = [nodes_copy.pop]
        nodes_copy.each do |node|
            if node.final_score > best_nodes.first.final_score
                best_nodes = [node]
            elsif node.final_score == best_nodes.first.final_score
                best_nodes << node
            end
        end
        best_nodes.shuffle.first
    end
end