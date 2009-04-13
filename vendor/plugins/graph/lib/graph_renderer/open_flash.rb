module graph_renderer  
  class OpenFlash < Base
    include OpenFlashChart
    def fix_color(color)
      color.split(//).inject("") {|str, char| "#{str}#{char}0" }.sub("#0", "#")
    end
    def render(resource, options = {})
      graph = OpenFlashChart.new
      graph.set_title(Title.new(resource.title))
      graph.set_colours(fix_color(resource.color), fix_color(resource.background_color))
      x_legend = XLegend.new(resource.x_label)
      x_legend.set_style('{font-size: 20px; color: #778877}')
      y_legend = YLegend.new(resource.y_label)
      y_legend.set_style('{font-size: 20px; color: #778877}')
      y = YAxis.new
      y.set_range(0, 10000, 1000)
      graph.y_axis = y
      graph.set_x_legend(x_legend)
      graph.set_y_legend(y_legend)
      resource.graph_items.each do |item|
        line = Line.new
        line.text = item.title
        line.width = 1
        mcolor = fix_color(item.color)
        
        line.colour = mcolor
        data = item.data_source.values(options)
        line.values = data.collect {|v| v[:y_value] }
        graph.add_element(line)
        num_labels = 5
        num_items = data.size
        per_label = num_items/num_labels
        x_labels = XAxisLabels.new
        labels = []
        data.each_with_index do |v, idx|
          
          if idx % per_label == 0
            labels << XAxisLabel.new(v[:x_value].strftime("%m/%d/%Y"), '#0f0', 10, "vertical") 
          else
            labels << nil
          end
        end
        x_labels.labels = labels
        x = XAxis.new
        x.set_tick_height(20)
        x.set_steps(per_label)
        x.set_labels(x_labels)        
        graph.x_axis = x
      end
      return graph
    end
    
  end
end
