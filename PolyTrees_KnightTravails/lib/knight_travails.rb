require_relative "00_tree_node.rb"

class KnightPathFinder

    attr_accessor :considered_positions, :starting, :start_n

    def initialize(starting = [0,0])
        @starting = starting
        @considered_positions = [starting]
        build_move_tree
    end



   

    def self.valid_moves(pos)
        # 1 finds new positions 
        offset = [[2,1],[1,-2],[2,-1],[-2,1],[1,2],[-1,2],[-2,-1],[-1,-2]]
        offset.map! do |position|
            #p position
            position[0] += pos[0]
            position[1] += pos[1]
            position
        end
        offset.select! { |pos| (pos[0] >= 0 && pos[0] <= 8) && (pos[1] >= 0 && pos[1] <= 8) } 
        return offset
    end

    def new_move_positions(position)
        #2 move tree minus considered positions, filter out considered positions
        # return an array of moves
        possible_moves = KnightPathFinder.valid_moves(position)
        possible_moves.select! {|idx| !@considered_positions.include?(idx)}
        @considered_positions += possible_moves
        # p possible_moves
        # p @considered_positions
        possible_moves

    end

    

    def build_move_tree
        #calls new move positions, then builds move tree from starting/current node
        @start_n = PolyTreeNode.new(@starting)
        arr = [@start_n]
        until arr.empty?
            start_node = arr.shift
            positions = new_move_positions(start_node.value)
            if !positions.nil?
                positions.each do |pos|
                    node = PolyTreeNode.new(pos)
                    node.parent = start_node
                    start_node.add_child(node)
                    arr << node
                end
            end
            
        end

    end

    def find_path(target)
        #build tree, check if children include target position
        #select best position if target doesn't exist within 1 move
        #add move to array
        #generate next layer of move tree based on prev position (child of selected node)
        
        trace_path_back(@start_n.bfs(target))

    end

    def trace_path_back(node)
        current = node
        path = [current.value]
        until current.value == @start_n.value
            current = current.parent
            path.unshift(current.value)
        end
        path
    end

end



#p KnightPathFinder.valid_moves([3,3])

 k = KnightPathFinder.new()
#   k.considered_positions << [2,1]
#  k.new_move_positions([3,3])

# p k.starting.dfs([3,3])
# p k.starting.dfs([4,5])

kpf = KnightPathFinder.new([0, 0])
p kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
p kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]
