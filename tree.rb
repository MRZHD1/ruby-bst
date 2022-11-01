class Node
  attr_accessor :data
  attr_accessor :left
  attr_accessor :right

  def initialize(data, left=nil, right=nil)
    @data = data
    @left = left
    @right = right
  end
end

class Tree
  attr_accessor :root
  def initialize(arr)
    @root = build_tree(arr.sort.uniq)
  end

  def build_tree(arr)
    len = arr.length/2
    if len > 1
      left = arr[..len]
      right = arr[len+1..]    
      parent = left.pop
      parent = Node.new(parent)
      parent.left = build_tree(left)
      parent.right = build_tree(right)
      return parent
    elsif len == 1
      parent = Node.new(arr.pop)
      unless arr.nil?
        parent.left = Node.new(arr.pop)
      end
      return parent
    else
      return nil
    end    
  end

  def insert(root, value)
    if root == nil
      return Node.new(value)
    else
      if root.data == value
        return root
      elsif root.data < value
        root.right = insert(root.right, value)
      else
        root.left = insert(root.left, value)
      end
    end
    return root
  end
  
  def find_min(node)
    curr = node
    until curr.left == nil
      curr = curr.left
    end
    return curr
  end

  def delete(root, value)
    if root == nil
      return root
    end

    if value < root.data
      root.left = delete(root.left, value)
    elsif value > root.data
      root.right = delete(root.right, value)
    else
      if root.left == nil
        t = root.right
        root = nil
        return t
      elsif root.right == nil
        t = root.left
        root = nil
        return t 
      else
        t = find_min(root.right)
        root.data = t.data
        root.right = delete(root.right, t.data)
      end
    end
    return root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end



tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
tree.insert(tree.root, 10)
tree.insert(tree.root, 11)
tree.insert(tree.root, 12)
tree.insert(tree.root, 15)
tree.insert(tree.root, 19)
puts tree.pretty_print
tree.delete(tree.root, 9)
puts tree.pretty_print