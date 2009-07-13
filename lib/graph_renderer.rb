module GraphRenderer
  class Base
    def render(graph_record, ds_options = {})
      raise "GraphRenderer::render should be overridden in subclasses"
    end

    def rpn(expr)
      rpn_r(expr.split)
    end
    def rpn_r(v)
      tk = v.pop
      if tk=~/^[-+*\/]$/
        y,x = rpn_r(v),rpn_r(v)
        x.send(tk,y)
      else
        Float(tk)
      end
    end
  end
end

