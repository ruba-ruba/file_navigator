module ApplicationHelper

  def nested_tree(object)
    object.map do |object, parent|
      render(object) + content_tag(:div, nested_tree(parent), :class => "nested_tree", :id => dom_id(object)) 
    end.join.html_safe
  end

end
