module MapsHelper

  def indicator_list
    indicators = {}
    DataSourceTemplate.find(:all).each do |ds|
      indicators[ds.identifier] = ds.name
    end
    indicators.invert
  end

  def draw_map(map, width, height)
    render :partial => '/maps/map', :locals => {:map => map, :width => width, :height => height }
  end
end
