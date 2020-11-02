require_relative 'board.rb'
require_relative './pieces/piece.rb'

class Chess_Node
    attr_reader :children, :board, :active_player_color
    attr_accessor :parent, :children, :previous_move, :depth
    
    def initialize(board, evaluator_color, active_player_color, depth)
        @board = board
        @parent = nil
        @children = []
        @evaluator_color = evaluator_color
        @active_player_color = active_player_color
        @opponent_color = Board.opposite_color(evaluator_color)
        @depth = depth
        @previous_move = nil
        @checkmate = nil
    end

    def final_score
        compute_final_score if @final_score == nil
        @final_score
    end

    def grow_tree(current_depth, max_depth)
        clear_score
        @depth = current_depth
        unless @depth >= max_depth || checkmate?
            add_children if leaf?
            children.each do |child| 
                child.grow_tree(current_depth + 1, max_depth)
            end
        end
        compute_final_score
    end

    def prune_tree(new_root_board)
        queue = [self]
        while queue.length > 0
            node = queue.shift
            if (
                node.board == new_root_board &&
                node.active_player_color == @evaluator_color 
            )
                return make_root(node)
            end 
            queue.concat node.children
        end
        raise "could not find new_root_board"
        nil
    end

    def leaf?
        children.empty?
    end

    def checkmate?
        if @checkmate == nil
            @checkmate = @board.checkmate?(@evaluator_color) || 
                         @board.checkmate?(@opponent_color)
        end
        @checkmate
    end

    private
    def add_children
        moves = all_valid_moves(@active_player_color)
        moves.each { |move| add_child(move)}
    end

    def add_child(move)
        new_board = @board.dup
        new_board.move_piece!(*move)
        next_color = Board.opposite_color(@active_player_color)
        node = Chess_Node.new(new_board, @evaluator_color, next_color, @depth + 1)
        node.parent = self
        node.previous_move = move
        @children << node
    end 

    def compute_final_score
        if @children.empty?
            score_leaf_node
        else
            if @active_player_color == @evaluator_color
                @final_score = children.max { |child| child.final_score }.final_score
            else
                @final_score = children.min { |child| child.final_score }.final_score
            end
        end
    end

    def score_leaf_node
        if @board.checkmate?(@evaluator_color)
            @final_score = -1000
        elsif @board.checkmate?(@opponent_color)
            @final_score = 1000
        else
            evaluator_score = score_pieces(@evaluator_color)
            opponent_score = score_pieces(@opponent_color)
            @final_score = evaluator_score - opponent_score
        end
    end

    def score_pieces(color)
        pieces = @board.pieces(color)
        pieces.sum { |piece| piece.points }
    end

    def all_valid_moves(color)
        moves = []
        pieces = @board.pieces(color)
        pieces.each do |piece|
            start_pos = piece.pos
            piece.valid_moves.each { |end_pos| moves << [start_pos, end_pos] }
        end
        moves
    end

    def make_root(node)
        node.parent = nil
        node.previous_move = nil
        return node
    end

    def clear_score
        @final_score = nil
    end
end