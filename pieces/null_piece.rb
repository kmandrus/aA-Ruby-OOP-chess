require_relative 'piece.rb'
require 'singleton'

class Null_Piece < Piece
    include Singleton

    def initialize
        super(nil, :gray, nil)
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

end