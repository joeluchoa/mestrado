require 'rubygems'
require 'gnuplot'



#-------------------------------------
# reading input and creating the pragh
#-------------------------------------

n, m = gets.split.map { |i| i.to_i }

$graph = Array.new(n + 1).map { |i| i = [] }

m.times do 
  v, u, c, r = gets.split.map { |i| i.to_f }
  $graph[v.to_i] << { :destiny => u.to_i, :cost => c.to_i, :resource => r }
end

$graph.each { |list| list.sort! { |a, b| a[:destiny] <=> b[:destiny]} }



#------------------------------
# generating all paths of the graph
#------------------------------

$paths = []

def dfs(current, destiny, path_vertexes, path_cost, path_resource)
  return nil if path_vertexes.count(current) > 0

  path_vertexes << current

  if current == destiny
    $paths << {
      :vertexes => path_vertexes.clone, 
      :cost => path_cost,
      :resource => path_resource
    }
  else
    $graph[current].each do |edge|
      dfs(
        edge[:destiny], 
        destiny, 
        path_vertexes, 
        path_cost + edge[:cost],
        path_resource + edge[:resource]
      )
    end
  end

  path_vertexes.pop
end

dfs(1, n, [], 0, 0)

#----------------------------------------
# identifying paths used at the algorithm
#----------------------------------------

$used_paths = []

used_paths_vertexes = [
  [1,2,5,10],
  [1,2,6,10],
  [1,3,5,10],
  [1,3,6,10],
  [1,3,7,10],
  [1,4,7,10]
]

$paths.each do |path|
  $used_paths << path if used_paths_vertexes.count(path[:vertexes]) > 0
end



#---------------------------------------
# ploting datas and exporting the images
#---------------------------------------

Gnuplot.open do |gp|
  Gnuplot::Plot.new( gp ) do |plot|
    plot.border 0
    plot.zeroaxis
    plot.xtics 'axis'
    plot.ytics 'axis'
    plot.tics 'scale 0.1'

    plot.style 'line 1 lt 2 lc rgb "#999999" lw 1'
    plot.style 'line 2 lt 2 lc rgb "black" lw 1'


    plot.xrange "[0:25]"
    plot.yrange "[0:25]"
    plot.ylabel "eixo L"
    plot.xlabel "eixo u"

    $paths.each do |path|
      line = "#{path[:cost]} + #{path[:resource] - 1} * x"
      style = "ls #{$used_paths.count(path) == 0 ? 1 : 2}"
      title = path[:vertexes].join(', ')

      plot.data << Gnuplot::DataSet.new(line + " " + style) do |ds|
        ds.with = 'lines'
        ds.notitle
      end
    end

    #plot.terminal 'svg'
    #plot.output 'retas_lagrangeana.svg'
    #plot.terminal 'png'
    #plot.output 'retas_lagrangeana.png'
  end
end
