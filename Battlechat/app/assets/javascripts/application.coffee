#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require script.js
#= require pokemon.js
#= require_tree .

# Get the button that opens the modal

# When the user clicks the button, open the modal 
$(document).on "click", "#myBtn", ->
  $('#myModal').show()

# When the user clicks on <span> (x), close the modal
$(document).on 'click', 'span.close', ->
  $('#myModal').hide()

# When the user clicks anywhere outside of the modal, close it
$(document).on 'click', '#myModal', (event) ->
  if event.target.id == 'myModal'
    $('#myModal').hide()
