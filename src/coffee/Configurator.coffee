class Configurator
  CUBE_SIZE = 0
  
  separator =
    x: document.getElementById 'cube-separator-x'
    y: document.getElementById 'cube-separator-y'

  constructor: (size) ->
    CUBE_SIZE = size
    do createSeparatorSliders

  createSeparatorSliders = ->
    Array.prototype.slice.call(document.getElementsByClassName 'separator-slider').forEach (item) ->
      noUiSlider.create item,
        start: -CUBE_SIZE / 2
        step: 1
        range:
          min: -CUBE_SIZE,
          max: 0

      item.noUiSlider.on 'update', (values) ->
        value = parseInt values[0], 10
        separatorAxis = this.target.getAttribute 'data-separator-target'

        if separatorAxis is 'x'
          separator.x.style.transform = "translateZ(#{value}px)"
        else if separatorAxis is 'y'
          separator.y.style.transform = "translateZ(#{value}px)"