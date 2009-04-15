module GraphRenderer  
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
                    