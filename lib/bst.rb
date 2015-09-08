require 'node'
require 'pry'

class Bst
  attr_accessor :head

  def initialize(head = nil)
    @head = head
  end

  def insert(data)
    if head
      set_node(head, data)
    else
      self.head = Node.new(data)
    end
    self
  end

  def set_node(current, data)
    loop do
      if data < current.data
        current = set_left(current, Node.new(data))
      else
        current = set_right(current, Node.new(data))
      end
      break if current == self
    end
  end

  def set_left(current, node)
    if current.left.nil?
      current.left = node
      return self
    else
      current = current.left
    end
    current
  end

  def set_right(current, node)
    if current.right.nil?
      current.right = node
      return self
    else
      current = current.right
    end
    current
  end

  def import(filename)
    file = File.open("./test/fixtures/#{filename}")
    file.each_line { |data| insert(data.chomp) } if head.nil?
    file.close
  end

  def include?(data)
    return true if head.data == data
    current = head
    loop do
      if data < current.data
        return false if current.left.nil?
        return true if current.left.data == data
        current = current.left
      else
        return false if current.right.nil?
        return true if current.right.data == data
        current = current.right
      end
    end
  end

  def depth_of(data)
    return 1 if head.data == data
    return 2 if head.left.data == data ||
                head.right.data == data
    current = head
    depth = 2
    loop do
      if data < current.data
        return false if current.left.nil?
        return depth if current.left.data == data
        current = current.left
      elsif data > current.data
        return false if current.right.nil?
        return depth if current.right.data == data
        current = current.right
      end
      depth += 1
    end
  end

  def maximum
    return if head.nil?
    current = head
    loop do
      return current.data if current.right.nil?
      current = current.right
    end
  end

  def minimum
    return if head.nil?
    current = head
    loop do
      return current.data if current.left.nil?
      current = current.left
    end
  end

  def sort(node, sorted)
    sort(node.left, sorted) unless node.left.nil?
    sorted << node.data
    sort(node.right, sorted) if node.right
    sorted
  end

  def delete!(data)
    return unless self.include?(data)
    sorted = []
    if head.data == data
      sorted = sort(head, sorted)
      self.head = nil
    end
    current = find(head, data)
    clip_branch(sorted, current, data)
    repair(sorted, data)
  end

  def clip_branch(sorted, current, data)
    if data == current.right.data
      sorted = sort(current.right, sorted)
      current.right = nil
    else
      sorted = sort(current.left, sorted)
      current.left = nil
    end
    sorted
  end

  def find(current, data)
    return head if head.data == data
    unless current.right.data == data ||
           current.left.data == data
      if data < current.data
        current = current.left
      else
        current = current.right
      end
    end
    current
  end

  def repair(sorted, data)
    sorted.delete(data) # Array#delete
    sorted.each { |value| insert(value) }
  end

  def leaves(node, leaves)
    leaves(node.left, leaves) unless node.left.nil?
    leaves(node.right, leaves) if node.right
    leaves << node.data if node.left.nil? &&
                           node.right.nil?
    leaves
  end

  def max_height(node, depths)
    max_height(node.left, depths) unless node.left.nil?
    depths << depth_of(node.data)
    max_height(node.right, depths) if node.right
    depths.max
  end

  def export_sorted(filename)
    file = File.open("./test/fixtures/#{filename}", 'w')
    sorted = []
    sorted = sort(head, sorted)
    sorted.each { |value| file.write(value + "\n") }
    file.close
  end
end
