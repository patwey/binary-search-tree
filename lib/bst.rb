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
    else
      current = self.head

      loop do
        if current.left.nil? && current.right.nil?
          if node.data < current.data
            current.left = node
            node.parent = current
            return self
          else
            current.right = node
            node.parent = current
            return self
          end
        end

        if node.data < current.data
          if current.left.nil?
            current.left = node
            node.parent = current
            return self
          else
            current = current.left
            next
          end
        elsif node.data > current.data
          if current.right.nil?
            current.right = node
            node.parent = current
            return self
          else
            current = current.right
            next
          end
        end
      end
    end
    self
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

  def left(node, sorted)
    if node.left
      left(node.left, sorted)
    else
      sorted << node.data
      right(node, sorted)
    end
  end

  def right(node, sorted)
    if node.right
      if !sorted.include?(node.right.data)
        left(node.right, sorted)
      end
    else
      backtrack(node, sorted)
    end
  end

  def backtrack(node, sorted)
    return if node.parent.nil?
    node = node.parent
    if sorted.include?(node.data)
      backtrack(node, sorted)
    else
      sorted << node.data
      right(node, sorted)
    end
  end

  def sort
    sorted = []
    return sorted if self.head.nil?
    left(self.head, sorted)
    sorted
  end

end
