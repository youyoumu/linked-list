class LinkedList
  attr_accessor :size

  def initialize
    @head = Node.new
    @size = 1
  end

  def head
    @head.value
  end

  def tail
    get_tail.value
  end

  def get_tail(node = @head)
    if @head == nil
      tail = @head
    elsif node.next_node == nil
      tail = node
    else
      tail = get_tail(node.next_node)
    end
    return tail
  end

  def append(value)
    tail = get_tail()
    if @head.value == nil
      @head = Node.new(value)
    else
      tail.next_node = Node.new(value)
    end
  end

  def prepend(value)
    temp = @head
    @head = Node.new(value)
    @head.next_node = temp
  end

  def at(index)
    return get_value(@head, 0, index)
  end

  def get_value(node , counter, index)
    return node.value if counter == index
    get_value(node.next_node, counter + 1, index)
  end

  def pop
    tail = get_tail
    before_tail = get_before_tail(@head, tail)
    before_tail.next_node = nil
  end

  def get_before_tail(node, tail)
    return node if node.next_node == tail
    get_before_tail(node.next_node, tail)
  end

  def contains?(value)
    return check_value(@head, value)
  end

  def check_value(node, value)
    return false if node == nil
    return true if node.value == value
    check_value(node.next_node, value)
  end

  def find(value)
    return nil unless contains?(value)
    return check_index(@head, 0, value)
  end

  def check_index(node, index, value)
    return index if node.value == value
    check_index(node.next_node, index + 1, value)
  end

  def update_size(node = @head)
    return if node.next_node == nil
    @size += 1
    update_size(node.next_node)
  end

  def to_s(node = @head)
    if node == nil
      puts ""
      return
    end
    print "#{node.value} -> "
    to_s(node.next_node)
  end

end

class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

list = LinkedList.new
list.append(1)
list.append(3)
list.prepend("a")
list.prepend("b")
list.to_s
list.update_size
puts "size: #{list.size}"
puts "head: #{list.head}"
puts "tail: #{list.tail}"
puts list.at(1)
list.pop
list.append(5)
list.to_s
puts list.contains?("c")
puts list.contains?(5)
puts list.find("a")
