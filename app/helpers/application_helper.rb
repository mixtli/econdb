# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def category_tree
    result = '<ul>'
    Category.roots.each do |c|
      result += category_tree_node(c)
    end
    result += '</ul>'
    result
  end

  def category_tree_node(cat)
    result = "<li>" + link_to(cat.name, cat) 
    if cat.children.size > 0
      result += "<ul>"
      cat.children.each do |child|
        result += category_tree_node(child)
      end
      result += "</ul>"
    end
    result += "</li>"
    result
  end

end
