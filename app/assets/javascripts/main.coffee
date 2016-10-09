$(document).on 'turbolinks:load', ->
  class Draggable
    constructor: ->
      @drag_element = null
      @source_element = null
      $('[drag]').addClass('grab')

      $(document).on 'mousedown', (e) ->
        target = @source_element = $(e.target)
        if target.attr('drag') != undefined
          @source_element.addClass('grabbing')
          e.preventDefault()
          if target.attr('drag').length > 0
            @drag_element = $(target.attr('drag'))
          else
            @drag_element = target

          @init_x = @drag_element.offset().left - e.pageX
          @init_y = @drag_element.offset().top - e.pageY

      $(document).on 'mouseup', ->
        if @drag_element
          @source_element.removeClass('grabbing')
          @drag_element = null

      $(document).on 'mousemove', (e) ->
        if @drag_element and e.buttons == 1
          @drag_element.offset {top: e.pageY + @init_y, left: e.pageX + @init_x}

  draggable = new Draggable

  $('#preview').click (event) ->
  $('#item_image').click()

  $('#item_image').change (event) ->
    input = event.target
    if input.files
      reader = new FileReader()

      reader.onload = (e) ->
        $('#preview').attr 'src', e.target.result

      reader.readAsDataURL(input.files[0])
