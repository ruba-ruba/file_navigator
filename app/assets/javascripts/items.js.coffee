# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/



$ -> 
  #remove item
  $(".remove_item").bind "ajax:before", ->
    $(this).closest("tr").fadeOut()

  $('.remove_all_by_type').click ->
    $(this).remove()

  #$('form').on 'drop', ->
    setTimeout (->
      $('form').submit()
    ), 600

  $("#item_").change ->
    $('.btn').removeClass("hide")

  $("#new_item > .btn").click ->
    $('form').submit()