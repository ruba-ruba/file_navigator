$ ->
  $(".remove-flash").click ->
    $(".alert").remove()


  $(".multiple").toggle (->
    $(this).addClass "warning"
    id = $(this).attr("id")
    $("input[value="+id+"]").attr('checked', true)
  ), ->
    $(this).removeClass "warning"
    id = $(this).attr("id")
    $("input[value="+id+"]").attr('checked', false)

  $(".documents").click ->
    $(this).parent().addClass("active")
    $(".nav").parent().removeClass("active")
    $(".files").removeClass("hide")
    $(".tree").addClass("hide")

  $(".nav").click ->
    $(this).parent().addClass("active")
    $(".documents").parent().removeClass("active")
    $(".files").addClass("hide")
    $(".tree").removeClass("hide")






  #hight of nav div 
  height = $(".area").height()
  height = height - 4
  $(".navigation").css('height', height)



  #popover title
  $(".popover_title").popover({ 
                                trigger: "hover", 
                                placement:'bottom'
                              })




  #open folders tree
  name = $(".folder_dom_id").text()
  if name != ""
    element = "div[child_of="+name+"]"
    $(element).removeClass "hide"

    open_parent = (element) ->
      parent = $(element).parent()
      $(parent).removeClass "hide"
      if parent.parent().parent().attr("class") == "area"
        return false
      open_parent(parent)
    
    open_parent(element)