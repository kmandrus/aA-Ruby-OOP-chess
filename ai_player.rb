require_relative 'player.rb'
require_relative 'chess_node.rb'
require_relative 'board.rb'

class AI_Player < Player
    
    def initialize(color, display)
        super
    end

    def make_move(board)
        bfs_move(board, 4)
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
        root = Chess_Node.new(board, color, color, 1)
        root.make_tree(max_depth)
        nodes = root.children.dup
        best_nodes = [nodes.pop]
        nodes.each do |child|
            if child.final_score > best_nodes.first.final_score
                best_nodes = [child]
            elsif child.final_score == best_nodes.first.final_score
                best_nodes << child
            end
        end
        best_nodes.shuffle.first.previous_move
    end
    
end