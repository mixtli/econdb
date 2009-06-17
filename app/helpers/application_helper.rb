# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def category_tree(root = nil)
    result = '<ul>'
    collection = root ? root.children : Category.roots
    collection.each do |c|
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

  def current_category
    return Category.find(session[:category_id])
  end

  def root_category
    return current_category.root
  end
end
