require_relative 'chess_node.rb'
require_relative 'board.rb'
require_relative 'ai_player.rb'
require_relative 'game.rb'

#board = Board.new

#root = Chess_Node.new(board, :white, :black, 1)
#p root.all_valid_moves(:white).length
#p root.score_pieces(:white)
#p root.score_pieces(:black)

#p root.children.empty?
#p root.final_score

#move = [[6,2],[4,2]]
#root.add_child(move)
#p root.children.length

#root.add_children
#p root.children.length

#root.make_tree(4)
#Looks like 4 is about the reasonable limit for turn length, for now at least

game = Game.new()
game.play