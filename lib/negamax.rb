class Neganode
  attr_accessor :cell, :parent_node, :child_nodes, :score, :state, :depth
  def initialize(cell, child_nodes, score, state, depth, parent_node = nil)
    @cell = cell
    @parent_node = parent_node
    @child_nodes = child_nodes
    @score = score
    @state = state
    @depth = depth

  end

end
