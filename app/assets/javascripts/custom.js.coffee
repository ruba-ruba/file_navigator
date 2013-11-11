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




  #open folders tree for currnet folders
  name = $(".folder_dom_id").text()
  element = "div[child_of="+name+"]"

  open_parent = (element) ->
    $(element).removeClass "hide"
    attr = $(element).parent()
    if $(element).parent().attr("class") != "tree" 
      open_parent(attr)
  
  open_parent(element)