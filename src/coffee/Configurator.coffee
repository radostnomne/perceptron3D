class Configurator
  CUBE_SIZE = 0
  
  separator =
    x: document.getElementById 'cube-separator-x'
    y: document.getElementById 'cube-separator-y'

  mark =
    element: document.getElementById 'mark'
    transform: {}

  edges = Array.prototype.slice.call document.getElementsByClassName('js--cube-edge')

  constructor: (size) ->
    CUBE_SIZE = size
    do initSeparatorSliders
    do initMarkSliders
    do bindChangeEdgesOpacity

  initSeparatorSliders = ->
    Array.prototype.slice.call(document.getElementsByClassName 'separator-slider').forEach (slider) ->
      noUiSlider.create slider,
        start: -CUBE_SIZE / 2
        step: 1
        range:
          min: -CUBE_SIZE,
          max: 0

      slider.noUiSlider.on 'update', (values) ->
        value = parseInt values[0], 10
        separatorAxis = this.target.getAttribute 'data-axis'

        if separatorAxis is 'x'
          separator.x.style.transform = "translateZ(#{value}px)"
        else if separatorAxis is 'y'
          separator.y.style.transform = "translateZ(#{value}px)"

  initMarkSliders = ->
    Array.prototype.slice.call(document.getElementsByClassName 'slider_mark').forEach (slider) ->
      axis = slider.getAttribute 'data-axis'

      noUiSlider.create slider,
        start: 0
        step: 1
        range:
          min: 0,
          max: CUBE_SIZE
        orientation: if axis is 'y' then 'vertical' else 'horizontal'

      slider.noUiSlider.on 'update', (values) ->
        value = parseInt values[0], 10
        axis = this.target.getAttribute 'data-axis'

        mark.transform[axis] = "#{value ? 0}px"
        mark.element.style.transform = "translate3d(#{mark.transform.x}, #{mark.transform.y}, -#{mark.transform.z})"

  bindChangeEdgesOpacity = ->
    Array.prototype.slice.call(document.getElementsByClassName 'slider').forEach (slider) ->
      slider.noUiSlider.on 'start', ->
        edges.forEach (edge) ->
          edge.style.opacity = .5

      slider.noUiSlider.on 'end', ->
        edges.forEach (edge) ->
          edge.style.opacity = .9