require 'minitest'
require 'bst'
require 'pry'

class BstTest < Minitest::Test
  def setup
    @bst = Bst.new
    @bst.insert('d')
        .insert('b')
        .insert('a')
        .insert('c')
        .insert('f')
        .insert('e')
        .insert('g')

    @array = []
  end

  def test_i_can_insert_a_new_value_into_the_tree
    assert_equal 'd', @bst.head.data
    assert_equal 'b', @bst.head.left.data
    assert_equal 'c', @bst.head.left.right.data
    assert_equal 'g', @bst.head.right.right.data
  end

  def test_i_can_see_if_the_tree_includes_value
    assert @bst.include?('d')
    assert @bst.include?('b')
    assert @bst.include?('e')

    refute @bst.include?('y')
  end

  def test_i_can_find_the_depth_of_a_node_in_the_tree
    assert_equal 1, @bst.depth_of('d')
    assert_equal 2, @bst.depth_of('b')
    assert_equal 3, @bst.depth_of('a')

    refute @bst.depth_of('y')
  end

  def test_i_can_find_the_maximum_value_in_the_tree
    assert_equal 'g', @bst.maximum

    @bst.insert('h')
    assert_equal 'h', @bst.maximum
  end

  def test_i_can_find_the_minimum_value_in_the_tree
    @bst = Bst.new
    @bst.insert('d')
    assert_equal 'd', @bst.minimum

    @bst.insert('b')
    assert_equal 'b', @bst.minimum
  end

  def test_i_can_sort_tree_into_an_array_of_values_in_ascending_order
    @bst.insert('h')
    @array = @bst.sort(@bst.head, @array)

    assert_equal ['a','b','c','d','e','f','g','h'], @array
  end

  def test_i_can_delete_a_value_and_repair_the_tree
    @bst.delete!('f')

    assert_equal 'e', @bst.head.right.data
    assert_equal 'g', @bst.head.right.right.data
  end

  def test_i_can_find_the_leaves_of_the_tree
    @array = @bst.leaves(@bst.head, @array)

    assert_equal ['a', 'c', 'e', 'g'], @array
  end

  def test_i_can_find_the_maximum_height_of_the_tree
    @bst.insert('j')
        .insert('i')
    height = @bst.max_height(@bst.head, @array)

    assert_equal 5, height
  end
end
