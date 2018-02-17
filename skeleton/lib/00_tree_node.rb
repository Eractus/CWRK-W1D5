require 'byebug'

class PolyTreeNode
  def initialize(value, parent = nil, children = [])
    @value = value
    @parent = parent
    @children = children
  end

  def parent=(new_node)
    # cur_parent_children = @parent.children
    unless @parent.nil?
      @parent.children.each_index do |idx|
        @parent.children.delete_at(idx) if @parent.children[idx] == self
      end
    end
    @parent = new_node
    return nil if @parent.nil?
    @parent.children << self unless self.parent.children.include?(self)
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "Error" unless self.children.include?(child_node)
    self.children.delete(child_node)
    child_node.parent = nil
  end

  attr_reader :value, :children, :parent

  def dfs(target_val)
    return self if self.value == target_val
    result = nil
    self.children.each do |node|
      sub_search = node.dfs(target_val)
      if sub_search
        result = sub_search
        break
      end
    end
    result
  end

  def bfs(target_val)
    queue = Queue.new << self
    until queue.empty?
      node = queue.pop
      if node.value == target_val
        return node
      else
        node.children.each do |node1|
          queue << node1
        end
      end
    end
    nil
  end

end
