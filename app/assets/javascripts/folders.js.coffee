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

  #on submit hide modal
  $(document).on "ajax:success", "form", ->
    $('.modal, .modal-backdrop').remove()


