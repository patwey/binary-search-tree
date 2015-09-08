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
    @datafile = 'data.txt'
    @sortedfile = 'sorted.txt'
  end

  def test_it_can_insert_a_new_value_into_the_tree
    assert_equal 'd', @bst.head.data
    assert_equal 'b', @bst.head.left.data
    assert_equal 'c', @bst.head.left.right.data
    assert_equal 'g', @bst.head.right.right.data
  end

  def test_it_can_see_if_the_tree_includes_value
    assert @bst.include?('d')
    assert @bst.include?('b')
    assert @bst.include?('e')

    refute @bst.include?('y')
  end

  def test_it_can_find_the_depth_of_a_node_in_the_tree
    assert_equal 1, @bst.depth_of('d')
    assert_equal 2, @bst.depth_of('b')
    assert_equal 3, @bst.depth_of('a')

    refute @bst.depth_of('y')
  end

  def test_it_can_find_the_maximum_value_in_the_tree
    assert_equal 'g', @bst.maximum

    @bst.insert('h')
    assert_equal 'h', @bst.maximum
  end

  def test_it_can_find_the_minimum_value_in_the_tree
    @bst = Bst.new
    @bst.insert('d')
    assert_equal 'd', @bst.minimum

    @bst.insert('b')
    assert_equal 'b', @bst.minimum
  end

  def test_it_can_sort_tree_in_ascending_order
    @array = @bst.sort(@bst.head, @array)

    assert_equal ['a','b','c','d','e','f','g'], @array
  end

  def test_it_can_delete_a_value_and_repair_the_tree
    @bst.delete!('f')

    assert_equal 'e', @bst.head.right.data
    assert_equal 'g', @bst.head.right.right.data
  end

  def test_it_can_find_its_leaves
    @array = @bst.leaves(@bst.head, @array)

    assert_equal ['a', 'c', 'e', 'g'], @array
  end

  def test_it_can_find_the_maximum_height_of_the_tree
    @bst.insert('j')
        .insert('i')
    height = @bst.max_height(@bst.head, @array)

    assert_equal 5, height
  end

  def test_it_can_import_data_from_a_file
    @bst = Bst.new
    @bst.import(@datafile)
    assert_equal 'd', @bst.head.data
    assert_equal 'b', @bst.head.left.data
    assert_equal 'c', @bst.head.left.right.data
    assert_equal 'g', @bst.head.right.right.data
  end

  def test_it_can_export_data_to_a_file
    @bst.export_sorted(@sortedfile)
    file = File.open('./test/fixtures/sorted.txt')
    assert_equal 'a', file.readline.chomp
    assert_equal 'b', file.readline.chomp
    assert_equal 'c', file.readline.chomp
    file.close
  end
end
