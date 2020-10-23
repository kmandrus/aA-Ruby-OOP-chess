require_relative 'piece.rb'
require 'singleton'

class Null_Piece < Piece
    include Singleton

    def initialize
        super(nil, nil, nil)
    end

    def to_s
        "___"
    end

end