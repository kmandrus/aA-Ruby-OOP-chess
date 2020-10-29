require_relative 'piece.rb'
require 'singleton'

class Null_Piece < Piece
    include Singleton

    def initialize
        @color = :default
        @board = nil
        @pos = nil
    end

    def symbol
        :_
    end

    def empty?
        true
    end

    def moves
        []
    end

    def copy_to(new_board)
        raise "cannot copy singleton"
    end

end