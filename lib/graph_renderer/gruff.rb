module GraphRenderer  
  class Gruff < Base
    def render(resource, options = {})
      #return true
      returning ::Gruff::Line.new do |g|
        g.title = resource.title
        #g.x_axis_label = resource.x_label
        g.y_axis_label = resource.y_label
        g.background = resource.background_color
        g.font_color = resource.color
        g.bottom_margin = 60
        #g.hide_line_markers = true
        #g.marker_font_size = 10
        #g.legend_font_size = 10
        #g.hide_line_markers = true
        #g.minimum_value = resource.minimum_value
        #g.maximum_value = resource.maximum_value
        resource.graph_items.each do |item|
          RAILS_DEFAULT_LOGGER.debug "options = " + options.inspect
          data = item.data_source.values(options)
          RAILS_DEFAULT_LOGGER.debug "data: " +  data.inspect
          g.data(item.data_source.name, data.collect {|v| self.rpn(v[:y_value].to_s + " " + item.cdef.to_s) }, item.color)
          labels = {}
          num_labels = 12
          num_items = data.size
          per_label = (num_items.to_f/num_labels).ceil
          RAILS_DEFAULT_LOGGER.debug "num_items = #{num_items}, num_labels = #{num_labels}, per_label = #{per_label}"
          data.each_with_index do |v, idx|
            labels[idx] = v[:x_value].strftime("%m/%d/%y") if idx % per_label == 0
          end
          g.labels = labels
        end
      end
    end
  end
end

class Gruff::Base
  VERTICAL_LABEL_MARGIN = 50
  def background=(color1, color2=nil)
    color2 ||= color1
    @base_image = render_gradiated_background(color1, color2)
  end

    # Overridden to draw x labels vertically.
    def draw_label(x_offset, index)
      return if @hide_line_markers

      if !@labels[index].nil? && @labels_seen[index].nil?
        y_offset = @graph_bottom + VERTICAL_LABEL_MARGIN

        @d.fill = @font_color
        @d.font = @font if @font
        @d.stroke('transparent')
        @d.font_weight = NormalWeight
        @d.pointsize = scale_fontsize(@marker_font_size)
        @d.gravity = NorthGravity
        @d.rotation = -90.0
        @d = @d.annotate_scaled(@base_image,
        1.0, 1.0,
        x_offset, y_offset,
        @labels[index], @scale)
        @d.rotation = 90.0
        @labels_seen[index] = 1
        debug { @d.line 0.0, y_offset, @raw_columns, y_offset }
      end
    end


end
                    