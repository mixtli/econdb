# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include TagsHelper
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
    if session[:category_id]
      Category.find(session[:category_id])
    else
      Category.first
    end
  end

  def root_category
    return current_category.root
  end

  def is_admin?
    current_user && current_user.has_role?('admin')
  end
end
