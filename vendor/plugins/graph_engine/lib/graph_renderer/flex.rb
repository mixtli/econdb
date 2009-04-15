module GraphRenderer
  class Flex < Base
    def render(graph_record, ds_options = {})
      flex = case graph_record.chart_type
        when 'Line' then
        FlexChart::Line.new
        when 'Pie' then
        FlexChart::Pie.new
        when 'Area' then
        FlexChart::Area.new
        when 'Bar' then
        FlexChart::Bar.new
      else FlexChart::Base.new
      end
      flex.title = graph_record.title
      flex.x_label = graph_record.x_label
      flex.y_label = graph_record.y_label
      flex.x_axis_type = graph_record.x_axis_type
      flex.y_axis_type = graph_record.y_axis_type
      flex.color = graph_record.color
      flex.fill_color = graph_record.background_color
      graph_record.graph_items.each do |item|
        series = FlexChart::Series.new
        series.title = item.title
        series.color = item.color
        series.values = item.data_source.values(ds_options)
        flex.series << series
      end
      flex
    end
    
  end
end
