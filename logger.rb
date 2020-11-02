require_relative "chess_error.rb"
require_relative "chess_node.rb"
require_relative 'board.rb'

class Logger

    @@file_path = nil
    @@turn = nil
    @@active_color = nil

    def self.configure(file_path)
        @@file_path = file_path
        file = File.open(@@file_path, "a")
        file.print("\n\n\n")
        file.print("[ New Session ]\n\n")
        file.close
    end

    def self.update(turn, color)
        @@turn = turn
        @@active_color = color
    end

    def self.log(message)
        file = File.open(@@file_path, "a")
        file.print(self.prefix + message + "\n")
        file.close
    end

    def self.log_move(piece, move)
        file = File.open(@@file_path, "a")
        file.print(self.prefix + piece + " " + move.to_s + "\n")
        file.close
    end

    def self.log_error(error)
        file = File.open(@@file_path, "a")
        file.print(self.prefix + error.message + "\n")
        file.close
    end

    def self.log_node_and_children(node)
        file = File.open(@@file_path, "a")
        file.print(self.prefix + "Node and Children:\n")
        file.print("node:" + "\n" + node.board.to_s)
        node.children.each_with_index do |child, i|
            file.print("\t" + "child #{i}:\n")
            file.print(child.board.to_s)
        end
        file.close
    end

    private
    def self.prefix
        "[ turn #{@@turn} - #{@@active_color} ]  "
    end

end