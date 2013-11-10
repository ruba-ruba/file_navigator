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
