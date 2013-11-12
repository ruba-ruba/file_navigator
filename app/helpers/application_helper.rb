module ApplicationHelper

  def nested_tree(object)
    object.map do |object, parent|
      render(object) + content_tag(:div, nested_tree(parent), :class => "nested_tree hide", :child_of => dom_id(object)) 
    end.join.html_safe
  end

  def sortable(column, items_sort, title = nil)
    title ||= column.titleize
    css_class = (column.downcase == folder_sort_column) ? "current #{sort_direction}" : nil
    direction = (column.downcase == folder_sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction, :items_sort => items_sort, remote: true}, {:class => css_class}
  end


  def icon(file)
    file_type = file.item_file_name.split('.')[1]
    case 
    when %w(jpg jpeg bmp gif png).include?(file_type)
      "<i class='silk-images'></i>".html_safe
    when %w(aac mp3 flac wav).include?(file_type)
      "<i class='silk-music'></i>".html_safe
    when %w(doc docx).include?(file_type)
      "<i class='silk-page_word'></i>".html_safe
    when file_type == 'rb'
      "<i class='silk-ruby'></i>".html_safe
    when file_type == 'exe'
      "<i class='silk-cog'></i>".html_safe
    else
      "<i class='silk-attach'></i>".html_safe
    end
  end

end
