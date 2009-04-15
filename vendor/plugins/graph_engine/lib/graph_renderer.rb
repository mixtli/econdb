module GraphRenderer
  class Base
    def render(graph_record, ds_options = {})
      raise "GraphRenderer::render should be overridden in subclasses"
    end
  end
  
end

