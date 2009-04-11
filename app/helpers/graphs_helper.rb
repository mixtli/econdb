module GraphsHelper

  def setup_graph(graph)
    returning(graph) do |g|
      g.graph_items.build if g.graph_items.empty?
    end
  end
end
