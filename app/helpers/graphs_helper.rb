module GraphsHelper
  def color_picker(name, value = "#0f0")                                                                                      
    value ||= "0f0"                                                                                                           
    #build the hexes                                                                                                          
    hexes = []                                                                                                                
     (0..15).step(3) do |one|                                                                                                 
     (0..15).step(3) do |two|
     (0..15).step(3) do |three|
          hexes << "#" + one.to_s(16) + two.to_s(16) + three.to_s(16)
        end
      end
    end
    arr = []
    10.times { arr << "&nbsp;" }
    returning html = '' do
      html << "<select name=\"#{name}\" style='background-color: #{value}' onchange=\"this.style.backgroundColor = this.value;\">"
      hexes.each do |c|
        html << "<option value='#{c}' style='background-color: #{c}'"
        if c == value.downcase
          html << " selected "
        end
        html << ">#{arr.join}</option>\n"
      end
      html << "</select>"
    end
  end
  
  def graph_flash_vars
    params[:start] = @start_time.strftime("%Y:%m:%d %h:%m:%s")
    params[:end] = @end_time.strftime("%Y:%m:%d %h:%m:%s")
    #params.map { |k,v| "%s=%s" % [URI.encode(k.to_s), URI.encode(v.to_s)] } unless params.blank?
    params
  end
  
  def open_flash_chart(*options)
    controller.open_flash_chart_object(*options)
  end
  
  def add_graph_item_link(form_builder)
    link_to_function 'Add a Graph Item' do |page|
      newitem = GraphItem.new
      newitem.build_data_source
      form_builder.fields_for :graph_items, newitem, :child_index => 'NEW_RECORD' do |f|
        html = render(:partial => 'graph_item', :locals => { :form => f })
        page << "$('graph_items').insert({ bottom: '#{escape_javascript(html)}'.replace(/NEW_RECORD/g, new Date().getTime()) });"
      end
    end
  end
  
  def remove_graph_item_link(form_builder)
    if form_builder.object.new_record?
      link_to_function("Remove Graph Item", "$(this).up('.graph_item').remove();");
    else
      form_builder.hidden_field(:_delete) + link_to_function("Remove Graph Item", "$(this).up('.graph_item').hide(); $(this).previous().value = '1'")
    end
  end
  
  def graph_params
    p = params.dup
    p.delete(:id)
    p.delete(:controller)
    p.delete(:action)
    p
  end


end
