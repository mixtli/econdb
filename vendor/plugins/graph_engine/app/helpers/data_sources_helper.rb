module DataSourcesHelper
  def display_plugin_arguments(name, resource, options)
    case options[:type]
      when 'select_tag' then select_tag "data_source[arguments][#{name}]", options_for_select(options[:options])
      else eval "#{options[:type]} \"data_source[arguments][#{name}]\", resource.arguments[name]"
    end
  end

end
