$ ->
  $(".remove-flash").click ->
    $(".alert").remove()


 # $(".multiple").click ->
 #   $(this).toggleClass "warning"


  $(".multiple").toggle (->
    $(this).addClass "warning"
    id = $(this).attr("id")
    $("input[value="+id+"]").attr('checked', true)
  ), ->
    $(this).removeClass "warning"
    id = $(this).attr("id")
    $("input[value="+id+"]").attr('checked', false)
