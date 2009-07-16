module GraphRenderer
  class GnuPlot < Base
    def render(graph, options = {})
      file = Tempfile.new("gnuplot")
      ::Gnuplot.open do |gp|
        Gnuplot::Plot.new( gp ) do |plot|
          plot.title  graph.title
          plot.ylabel  graph.y_label
          plot.xlabel  graph.x_label
          plot.xtics  "rotate"
          plot.xdata  "time"
          plot.timefmt '"%m/%d/%Y"'
          plot.format 'x, "%m/%d/%Y"'

          plot.terminal "png"
          plot.output file.path

          graph.graph_items.each do |item|
            data = item.data_source.data.find(:all, :conditions => ["timestamp BETWEEN ? AND ?", options[:start], options[:end]])
            plot.data <<  Gnuplot::DataSet.new( [data.collect {|d| d.timestamp.strftime("%m/%d/%Y")}, data.collect(&:value)] ) { |ds|
              ds.with = "linespoints"
              ds.using = "1:2"
              ds.title = item.data_source.name
            }
          end

        end
      end
      file.read
    end
  end
end
