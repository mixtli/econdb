module DataSourcesHelper
  def display_plugin_arguments(name, resource, options)
    case options[:type]
      when 'select_tag' then select_tag "data_source[arguments][#{name}]", options_for_select(options[:options])
      else eval "#{options[:type]} \"data_source[arguments][#{name}]\", resource.arguments[name]"
    end
  end

  def data_source_options
    #Rails.cache.fetch("data_source_options") do
      options = []
      #ObjectSpace.to_enum(:each_object, class << DataSource; self; end).to_a.each  do |klass|
      DataSource.send(:subclasses).each do |klass|
      #next if klass == DataSource
        options << [ klass.to_s.sub("DataSource::",""), klass.to_s ]
      end
      options.uniq
    #end
  end



  def data_source_field(data_source, name)
    logger.debug "ds = #{data_source}, name = #{name}"
    opts = data_source.options_for(name)
    if opts
      select_tag "data_source[arguments][#{name}]", options_for_select(opts, data_source.arguments[name.to_sym])
    else 
      text_field_tag "data_source[arguments][#{name}]", data_source.arguments[name.to_sym] 
    end
  end


end
