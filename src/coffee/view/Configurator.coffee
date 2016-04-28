class Configurator
  
  separator =
    x: document.getElementById 'cube-separator-x'
    y: document.getElementById 'cube-separator-y'
    z: document.getElementById 'cube-separator-z'
    position: {}
    captionElement: document.getElementById 'separators-position'

  mark =
    element: document.getElementById 'mark'
    captionElement: document.getElementById 'mark-position'
    transform: {}

  edges = Array.prototype.slice.call document.getElementsByClassName('js--cube-edge')
  opacity = .9

  
  
  constructor: ->
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

        separator.position[axis] = value
        separator[axis].style.transform = "translateZ(#{value}px)"

        separator.captionElement.textContent = "X: #{separator.position.x}, Y: #{separator.position.y}, Z: #{separator.position.z}"

          
          
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

        mark.captionElement.textContent = "X: #{mark.transform.x}, Y: #{mark.transform.y}, Z: #{mark.transform.z}"



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
      opacity = value
      setEdgesOpacity value



  bindChangeEdgesOpacity = ->
    Array.prototype.slice.call(document.getElementsByClassName 'js--edge-control-slider').forEach (slider) ->
      slider.noUiSlider.on 'start', ->
        if opacity > .6
          setEdgesOpacity .6

      slider.noUiSlider.on 'end', ->
        if opacity > .6
          setEdgesOpacity opacity



  setEdgesOpacity = (opacity) ->
    edges.forEach (edge) ->
      color = getComputedStyle(edge).backgroundColor.replace('rgba(', '').replace(')', '').split(', ')
      edge.style.backgroundColor = "rgba(#{color[0]}, #{color[1]}, #{color[2]}, #{opacity})"