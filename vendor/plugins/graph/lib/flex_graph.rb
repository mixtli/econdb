module FlexGraph
  class Base
    attr_accessor :title, :x_label, :y_label, :series, :x_axis_type, :y_axis_type, :color, :fill_color
    
    def initialize(options = {})
      @series = []
      @x_axis_type = "Linear"
      @y_axis_type = "Linear"
    end
    
    def fix_color(color)
      c = color.sub("#", "")
      newstr = ""
      c.each_char {|char| newstr << "#{char}0" }
      "0x" + newstr
    end
    
    def to_xml
      xml = Builder::XmlMarkup.new
      xml.graph do
        xml.title(@title)
        xml.x_label(@x_label)
        xml.y_label(@y_label)
        xml.x_axis_type(@x_axis_type)
        xml.y_axis_type(@y_axis_type)
        xml.color(fix_color @color)
        xml.fill_color(fix_color @fill_color)
        xml.chart_type(self.class.to_s.split("::")[1])
        series.each do |item|
          xml.graph_item do
            xml.title(item.title)
            xml.color(fix_color item.color)
            xml.dataset do
              item.values.each do |data|
                xml.data do
                  xml.x_value(data[:x_value].strftime("%m/%d/%Y"))
                  xml.y_value(data[:y_value])
                end
              end
            end
          end
        end
      end    
    end
  end  

  class Series
    attr_accessor :title, :color, :values
  end

  class Line < Base
  end
 
  class Pie < Base
  end

  class Area < Base
  end

end
