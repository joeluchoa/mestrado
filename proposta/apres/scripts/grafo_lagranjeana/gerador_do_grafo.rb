require 'rubygems'
require 'graphviz'


g = GraphViz.new( :G, :type => :digraph, :use => 'dot')

g.node[:shape] = 'circle'
g.node[:style] = 'filled'
g.node[:fontname] = 'monospaced'
g.node[:fontsize] = 12

g.edge[:penwidth] = 1 
g.edge[:arrowsize] = 0.5
g.node[:fontname] = 'monospaced'
g.edge[:fontsize] = 12 

n, m = gets.split.map { |i| i.to_i }

1.upto(n) { |i| g.add_node(i.to_s) }

m.times do
  v, u, c, r = gets.split
  g.add_edge( g.get_node(v), g.get_node(u), :label => "(#{c},#{r})  ")
end

output_name = 'grafo_lagrangeana'
g.output(:png => output_name + '.png')
g.output(:svg => output_name + '.svg')
