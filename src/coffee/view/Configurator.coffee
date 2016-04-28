class Configurator
  CUBE_SIZE = 0
  
  separator =
    x: document.getElementById 'cube-separator-x'
    y: document.getElementById 'cube-separator-y'
    z: document.getElementById 'cube-separator-z'

  mark =
    element: document.getElementById 'mark'
    transform: {}

  edges = Array.prototype.slice.call document.getElementsByClassName('js--cube-edge')

  cube = document.getElementById 'cube'

  
  
  constructor: (size) ->
    CUBE_SIZE = size
    do initSeparatorSliders
    do initMarkSliders
    do bindOpacitySlider
    do bindChangeEdgesOpacity



  getMarkPosition: ->
    mark.transform



  initSeparatorSliders = ->
    Array.prototype.slice.call(document.getElementsByClassName 'slider_separator').forEach (slider) ->
      noUiSlider.create slider,
        start: -CUBE_SIZE / 2
        step: 1
        range:
          min: -CUBE_SIZE,
          max: 0

      slider.noUiSlider.on 'update', (values) ->
        value = parseInt values[0], 10
        axis = this.target.getAttribute 'data-axis'

        separator[axis].style.transform = "translateZ(#{value}px)"

          
          
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

        mark.transform[axis] = parseInt "#{value ? 0}", 10
        mark.element.style.transform = "translate3d(#{mark.transform.x}px, #{mark.transform.y}px, -#{mark.transform.z}px)"



  bindOpacitySlider = ->
    slider = document.getElementById 'opacity-slider'

    noUiSlider.create slider,
      start: 9
      step: 1
      range:
        min: 0,
        max: 9

    slider.noUiSlider.on 'update', (values) ->
      value = parseInt(values[0], 10) / 10
      setEdgesOpacity value
      cube.setAttribute 'data-opacity', value



  bindChangeEdgesOpacity = ->
    Array.prototype.slice.call(document.getElementsByClassName 'js--edge-control-slider').forEach (slider) ->
      slider.noUiSlider.on 'start', ->
        if parseFloat(cube.getAttribute 'data-opacity') > .6
          setEdgesOpacity .6

      slider.noUiSlider.on 'end', ->
        opacity = parseFloat(cube.getAttribute 'data-opacity')
        if opacity > .6
          setEdgesOpacity opacity

  setEdgesOpacity = (opacity) ->
    edges.forEach (edge) ->
      color = getComputedStyle(edge).backgroundColor.replace('rgba(', '').replace(')', '').split(', ')
      edge.style.backgroundColor = "rgba(#{color[0]}, #{color[1]}, #{color[2]}, #{opacity})"