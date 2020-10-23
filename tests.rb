require_relative 'board.rb'

board = Board.new
board.debug_render

pawn = board[[1, 3]]
pos_1 = [3, 3]
pos_2 = [4, 3]
pos_3 = [5, 3]
pos_invalid = [6, 3]
board.move_piece(pawn.pos, pos_1)
board.debug_render
board.move_piece(pawn.pos, pos_2)
board.debug_render
board.move_piece(pawn.pos, pos_3)
board.debug_render
#board.move_piece(pawn.pos, pos_invalid)
#board.debug_render
atk = pawn.moves.first
board.move_piece(pawn.pos, atk)
board.debug_render

queen = board[[0, 3]]
p queen.moves
board.move_piece(queen.pos, [6,3])
board.debug_render
p queen.moves
#pos_1 = [3, 3]
#pos_2 = [3, 1]
#pos_3 = [0, 3]
#pos_4 = [1, 1]
#pos_5 = [5, 6]
#pos_6 = [4, 6]
#pos_7 = [1, 2]
#
#
#board[pos_1] = Rook.new(board, :white, pos_1)
#board[pos_2] = Rook.new(board, :black, pos_2)
#board[pos_3] = Rook.new(board, :white, pos_3)
#board[pos_4] = Bishop.new(board, :black, pos_4)
#board[pos_5] = Queen.new(board, :black, pos_5)
#board[pos_6] = King.new(board, :white, pos_6)
#board[pos_7] = Pawn.new(board, :white, pos_7)
#board.debug_render
#
#p board[pos_4]
#p board[pos_4].moves
#p board[pos_5].moves
#p board[pos_6].moves
#pawn = board[pos_7]
#p pawn.moves
#board.move_piece(pos_7, [2, 2])
#board.debug_render
#p pawn.moves