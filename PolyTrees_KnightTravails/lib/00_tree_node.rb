class PolyTreeNode
    attr_reader :value, :parent, :children

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end


    def parent=(node)
        #delete itself (child) from old parent's children
        #move itself to new parent
        #add itself to new parents' children
        @parent.children.delete(self) if @parent != nil
        @parent = node
        if node
            node.children << self if !node.children.include?(self)
        end


        # prev_parent = self.parent
        # @parent = node
        # node.children << self if !node.children.include?(self)
    end

    def add_child(child)
        child.parent = self
        
    end

    def remove_child(child)
        child.parent = nil

        raise if !@children.include?(child)
    end

    def inspect
        {"value:" => @value, "parent:" => @parent.value}.inspect

    end

    def dfs(target)
        found = self if @value == target

        @children.each do |child|
            found ||= child.dfs(target)
        end
        found
    end
    
    
    def bfs(target)
        array = []
        array << self
        
        until array.empty?
            current = array.shift
            if current.value == target
                return current
            else
                current.children.each do |child|
                    array << child
                end
            end
        end
        nil
    end

end