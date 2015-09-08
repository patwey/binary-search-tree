require 'node'
require 'minitest'

class NodeTest < Minitest::Test
  def setup
    @node = Node.new
  end

  def test_it_can_be_linked_to_other_nodes
    node_b = Node.new
    @node.left = node_b

    assert_equal node_b, @node.left
  end

  def test_it_node_can_be_given_data
    @node.data = 'a'

    assert_equal 'a', @node.data
  end
end
