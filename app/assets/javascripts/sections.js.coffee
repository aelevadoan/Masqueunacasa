$(document).on "nested:fieldAdded", (event) ->
  event.field.closest('.row').before(event.field)
  event.field.find('textarea.rte').markItUp(myMarkItUpSettings)

$(document).on "nested:fieldRemoved", (event) ->
  event.field.find('[required]').removeAttr('required')

init = ->
  $("form").on "change", "input[type='file']", ->
    thumb_container = $(this).closest('div.fields').find('.image-preview')
    img_tag = $("<img />")
    file = @files[0]
    reader = new FileReader()
    reader.onload = (event) ->
      img_tag.attr "src", event.target.result
      thumb_container.html img_tag

    reader.readAsDataURL file

$(document).ready(init)
$(window).bind('page:change', init)

