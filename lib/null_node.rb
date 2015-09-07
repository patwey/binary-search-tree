require_relative 'bst'
require_relative 'node'

class NullNode
  attr_accessor :data, :left, :right
  DEFAULT = new

  def initialize
    @data = nil
    @left = nil
    @right = nil
  end
end
