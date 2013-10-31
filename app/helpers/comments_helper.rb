module CommentsHelper
  def nested_comments(object)
    #binding.pry
    object.map do |object, parent|
      render(object) + content_tag(:div, nested_comments(parent), :class => "nested_message")
    end.join.html_safe
  end
end
