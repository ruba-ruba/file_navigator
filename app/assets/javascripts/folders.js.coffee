# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->

  #remove folder
  $(".remove_folder").bind "ajax:before", ->
    $(this).closest(".folder").fadeOut()

  #remove modal
  $(document).on "hidden", ".modal", ->
    $(this).remove()
    $("#error_explanation").remove()

  $('.delete_multiple').click ->
    $('#multiple_delete_form').submit();

  #on submit hide modal
  #$(document).on "ajax:complete", "form", ->
  #  $('.modal, .modal-backdrop').remove()

  $('#multiple_delete_form').on 'click', ->
    if $("#multiple_delete_form input[type=checkbox]:checked").length > 0
      $(".delete_multiple").removeClass('hide')
    else
      $(".delete_multiple").addClass('hide')



  $("i.icon-plus").on 'click', ->
    $(this).addClass('hide')
    id = $(this).attr('id')
    $("div[id="+id+"]").removeClass("hide")
    $(this).next().removeClass("hide")


  $("i.icon-minus").on 'click', ->
    $(this).addClass('hide')
    id = $(this).attr('id')
    $("div[id="+id+"]").addClass("hide")
    $(this).prev().removeClass("hide")
