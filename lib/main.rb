require_relative "tree.rb"
require_relative "node.rb"

# Testing
# rand_arr = Array.new(15) { rand(1..100) }
rand_arr = [49, 22, 85, 12, 35, 75, 89, 7, 16, 28, 47, 51, 77, 87, 94, 11, 14, 17, 32, 46, 48, 64, 76, 79, 88, 93, 99]


tree = Tree.new(rand_arr)

puts "Printing Tree..."
tree.pretty_print
puts ""

puts "Is tree balanced?"
p tree.balanced?
puts ""

puts "Level order traversal"
p tree.level_order
puts ""

puts "Preorder traversal"
p tree.preorder
puts ""

puts "Inorder traversal"
p tree.inorder
puts ""

puts "Postorder traversal"
p tree.postorder
puts ""

puts "Inserting multiple numers greater than 100 to unbalance tree"
10.times do
  num = rand(101..300)
  puts "  Inserting #{num}"
  tree.insert(num)
end
puts ""

puts "Printing Tree..."
tree.pretty_print
puts ""

puts "Is tree balanced?"
p tree.balanced?
puts ""

puts "Rebalancing tree..."
tree.rebalance
puts ""

puts "Is tree balanced?"
p tree.balanced?
puts ""

puts "Printing Tree..."
tree.pretty_print
puts ""

puts "Inserting 50..."
tree.insert(50)

puts "Inserting 12..."
tree.insert(12)

puts "Inserting 9..."
tree.insert(9)

puts "Printing Tree..."
tree.pretty_print
puts ""

puts "Deleting 50..."
tree.delete(50)
puts ""

puts "Printing Tree..."
tree.pretty_print
puts ""

puts "Deleting 12..."
tree.delete(12)
puts ""

puts "Printing Tree..."
tree.pretty_print
puts ""

puts "Deleting 9..."
tree.delete(9)
puts ""

puts "Printing Tree..."
tree.pretty_print
puts ""
