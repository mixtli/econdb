module GraphRenderer
  class Base
    def render(graph_record, ds_options = {})
      raise "GraphRenderer::render should be overridden in subclasses"
    end
  end
  
  class Flex < Base
    def render(graph_record, ds_options = {})
      flex = case graph_record.chart_type
        when 'Line' then
        FlexGraph::Line.new
        when 'Pie' then
        FlexGraph::Pie.new
        when 'Area' then
        FlexGraph::Area.new
        when 'Bar' then
        FlexGraph::Bar.new
      else FlexGraph::Base.new
      end
      flex.title = graph_record.title
      flex.x_label = graph_record.x_label
      flex.y_label = graph_record.y_label
      flex.x_axis_type = graph_record.x_axis_type
      flex.y_axis_type = graph_record.y_axis_type
      flex.color = graph_record.color
      flex.fill_color = graph_record.background_color
      graph_record.graph_items.each do |item|
        series = FlexGraph::Series.new
        series.title = item.title
        series.color = item.color
        series.values = item.data_source.values(ds_options)
        flex.series << series
      end
      flex
    end
    
  end
  
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
  
  class Gruff < Base
    def render(resource, options = {})
      returning ::Gruff::Line.new do |g|
        g.title = resource.title
        g.x_axis_label = resource.x_label
        g.y_axis_label = resource.y_label
        g.background = resource.background_color
        g.font_color = resource.color
        resource.graph_items.each do |item|
          data = item.data_source.values(options)
          g.data(item.data_source.name, data.collect {|v| v[:y_value].to_f}, item.color)
          labels = {}
          num_labels = 5
          num_items = data.size
          per_label = num_items/num_labels
          data.each_with_index do |v, idx|
            labels[idx] = v[:x_value].strftime("%m/%d/%Y") if idx % per_label == 0
          end
          g.labels = labels
        end
      end
    end
  end
end

class Gruff::Base
    def background=(color1, color2=nil)
      color2 ||= color1
      @base_image = render_gradiated_background(color1, color2)
    end
end