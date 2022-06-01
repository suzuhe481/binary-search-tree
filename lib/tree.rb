# Tree class which creates a binary search tree with a given array.
class Tree
  attr_accessor :root

  def initialize(array)
    array = array.sort.uniq
    start_index = 0
    end_index = array.length - 1
    
    @root = build_tree(array, start_index, end_index)
  end
  
  # Builds a binary search tree with given array.
  # Returns the root of the newly built tree.
  def build_tree(array, start_index = 0, end_index = array.length - 1)
    return nil if start_index > end_index
    
    mid = (start_index + end_index) / 2
    new_root = Node.new(array[mid])

    new_root.left = build_tree(array, start_index, mid - 1)
    new_root.right = build_tree(array, mid + 1, end_index)
    
    return new_root
  end

  # Accepts a value and inserts it as a node into the tree via iteration.
  # Returns root if root is nil.
  def insert(value, root = self.root)
    return root if root.nil?

    while (root.data > value && !root.left.nil?) || (root.data < value && !root.right.nil?)
      if value < root.data
        root = root.left
      elsif value > root.data
        root = root.right
      else
        # Node found
      end
    end

    if value < root.data
      root.left = Node.new(value)
    elsif value > root.data
      root.right = Node.new(value)
    else
      # Node already existing
    end

    return root
  end

  # Accepts a value and inserts it as a node into the tree via recursion.
  # Returns root if root is nil.
  def recursion_insert(value, root = self.root)
    return root if root.nil?
    
    if root.data < value && !root.right.nil?
      root = recursion_insert(value, root.right)
    elsif root.data > value && !root.left. nil?
      root = recursion_insert(value, root.left)
    elsif root.data == value
      # Value already exists
      return root
    else
      # Node found
    end

    if value < root.data
      root.left = Node.new(value)
    elsif value > root.data
      root.right = Node.new(value)
    end

    return root
  end

  # Finds a node with a minimum value in the right subtree of the given node.
  def find_min(node)
    current = node

    while current.right != nil
      current = current.right
    end

    return current
  end

  # Accepts a value and deletes it from the binary search tree.
  # Returns the root if value is not found.
  def delete(value, root = self.root)
    return root if root.nil?

    if value < root.data
      root.left = delete(value, root.left)
    elsif value > root.data
      root.right = delete(value, root.right)
    else
      # Node has no children or 1 child
      if root.left.nil?
        temp = root.right
        root = nil
        return temp
      elsif root.right.nil?
        temp = root.left
        root = nil
        return temp
      # Node has 2 children
      else
        temp_node = find_min(root.left)

        root.data = temp_node.data

        root.left = delete(root.left, temp_node.data)
      end
    end
    
    return root
  end

  # Accepts a value and returns the node with the given value.
  # Returns the root if the value is not found.
  def find_value(value, curr_node = self.root)
    return curr_node if curr_node.nil? || value == curr_node.data

    if value < curr_node.data
      curr_node = find_value(value, curr_node.left)
    elsif value > curr_node.data
      curr_node = find_value(value, curr_node.right)
    end

    return curr_node
  end

  # Accepts a node and returns the node with the given value.
  # Returns the root if the value is not found.
  def find_node(value_node, curr_node = self.root)
    return curr_node if curr_node.nil? || value_node == curr_node

    if value_node < curr_node
      curr_node = find_node(value_node, curr_node.left)
    elsif value_node > curr_node
      curr_node = find_node(value_node, curr_node.right)
    end

    return curr_node
  end

  # Traverses the binary tree in breadth-first level order.
  # Can accept a block.
  # Returns an array of values in breadth-first level order traversal if no block is given.
  def level_order(&print_block)
    return root if root.nil?

    queue = []
    data_array = []

    queue.append(root)

    until queue.empty?
      node = queue.shift
      
      data_array.append(node.data)
      
      yield(node) if block_given?

      if !node.left.nil?
        queue.append(node.left)
      end
      if !node.right.nil?
        queue.append(node.right)
      end
    end

    return data_array unless block_given?
  end

  # Traverses through the tree with inorder depth-first traversal.
  # Can accept a block.
  # Returns an array of values in inorder traversal if no block is given.
  def inorder(root = self.root, data_array = [], &print_block)
    return root if root.nil?

    inorder(root.left, data_array, &print_block)
    
    if block_given?
      yield root
    else
      data_array.append(root.data)
    end

    inorder(root.right, data_array, &print_block)

    return data_array unless block_given?
  end

  # Traverses through the tree with preorder depth-first traversal. 
  # Can accept a block.
  # Returns an array of values in preorder traversal if no block is given.
  def preorder(root = self.root, data_array = [], &print_block)
    return root if root.nil?

    if block_given?
      yield root
    else
      data_array.append(root.data)
    end

    preorder(root.left, data_array, &print_block)
    preorder(root.right, data_array, &print_block)

    return data_array unless block_given?
  end

  # Traverses through the tree with postorder depth-first traversal. 
  # Can accept a block.
  # Returns an array of values in postorder traversal if no block is given.
  def postorder(root = self.root, data_array = [], &print_block)
    return root if root.nil?

    postorder(root.left, data_array, &print_block)
    postorder(root.right, data_array, &print_block)

    if block_given?
      yield root
    else
      data_array.append(root.data)
    end

    return data_array unless block_given?
  end

  # Accepts a node or value and finds it's height.
  # Returns -1 if value is not in tree.
  def node_height(input_node)
    # If node is passed, extract it's data
    if input_node.instance_of?(Node)
      input_node = input_node.data
    end
    node = find_value(input_node)
    
    height = tree_height(node)

    return height
  end

  # Outputs the height of the tree. 
  # Height is the number of edges between the node and it's furthest leaf node.
  # Returns -1 if tree doesn't exist.
  def tree_height(curr_node = self.root)
    return -1 if curr_node.nil?

    [tree_height(curr_node.left), tree_height(curr_node.right)].max + 1
  end

  # Accepts a node and returns it's depth. Depth is the number of edges of the path from the node to the tree's root node.
  def depth(input_value, root = self.root)
    return root if root.nil?

    # If node is passed, extract it's data
    if input_value.instance_of?(Node)
      input_value = input_value.data
    end

    return 0 if root.data == input_value

    depth = 0

    until root.data == input_value
      if root.data > input_value
        root = root.left
      elsif root.data < input_value
        root = root.right
      end

      return if root.nil?

      depth += 1
    end

    return depth
  end

  # Returns true if the tree is balanced.
  # Balanced is when the heights of the left subtree and right subtree of every node differs by not no more than 1.
  def balanced?(root = self.root)
    return true if root.nil?

    left_height = node_height(self.root.left)
    right_height = node_height(self.root.right)

    if (left_height - right_height).abs <= 1 && 
        balanced?(root.left) && 
        balanced?(root.right)
      return true
    end

    return false
  end

  # Rebalances the binary search tree.
  # Returns the root of the new tree.
  def rebalance
    tree_values = level_order.sort.uniq
    
    start_index = 0
    end_index = tree_values.length - 1

    self.root = build_tree(tree_values, start_index, end_index)
  end

  # Method from The Odin Project to print a formatted tree.
  # https://www.theodinproject.com/lessons/ruby-binary-search-trees
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
