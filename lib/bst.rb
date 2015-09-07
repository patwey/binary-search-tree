require 'node'
require 'pry'

class Bst
  attr_accessor :head

  def initialize(head = nil)
    @head = head
  end

  def insert(data)
    node = Node.new(data)

    if self.head.nil?
      self.head = node
      return self
    end

      current = self.head

      loop do
        if data < current.data
          if current.left.nil?
            current.left = node
            return self
          else
            current = current.left
          end

        else
          if current.right.nil?
            current.right = node
            return self
          else
            current = current.right
          end
        end
      end
    self
  end

  def import(filename)
    file = File.open("./test/fixtures/#{filename}")
    file.each_line { |data| insert(data.chomp) } if head.nil?
    file.close
  end

  def include?(data)
    return true if head.data == data
    return true if head.left.data == data ||
                   head.right.data == data
    current = self.head
    loop do
      if data < current.data
        return false if current.left.nil?
        return true if current.left.data == data
        current = current.left
      elsif data > current.data
        return false if current.right.nil?
        return true if  current.right.data == data
        current = current.right
      end
    end
  end

  def depth_of(data)
    return 1 if head.data == data
    return 2 if head.left.data == data ||
                head.right.data == data
    current = self.head
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
    return if self.head.nil?

    current = self.head
    loop do
      return current.data if current.right.nil?
      current = current.right
    end
  end

  def minimum
    return if self.head.nil?

    current = self.head
    loop do
      return current.data if current.left.nil?
      current = current.left
    end
  end

  def sort(node, sorted)
    unless node.left.nil?
      sort(node.left, sorted)
    end
    sorted << node.data
    if node.right
      sort(node.right, sorted)
    end
    sorted
  end

  def delete!(data)
    return unless self.include?(data)
    current = self.head
    sorted = []

    if current.data == data
      sorted = sort(current, sorted)
      self.head = nil
    end

    unless current.right.data == data ||
           current.left.data == data
      if data < current.data
        current = current.left
      else
        current = current.right
      end
    end

    if data == current.right.data
      sorted = sort(current.right, sorted)
      current.right = nil
    end

    if data == current.left.data
      sorted = sort(current.left, sorted)
      current.right = nil
    end

    self.head.right
    sorted.delete(data) # Array#delete
    sorted
    sorted.each do |data|
      insert(data)
    end

  end

  def leaves(node, leaves)
    unless node.left.nil?
      leaves(node.left, leaves)
    end

    if node.right
      leaves(node.right, leaves)
    end

    if node.left.nil? && node.right.nil?
      leaves << node.data
    end
    leaves
  end

  def max_height(node, depths)
    unless node.left.nil?
      max_height(node.left, depths)
    end

    depths << depth_of(node.data)

    if node.right
      max_height(node.right, depths)
    end

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
