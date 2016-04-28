'use strict'

CUBE_SIZE = 200
ARRAY_CUBE_SIZE = 20

initApp = ->
  new Cube
  new Perceptron new Configurator



document.addEventListener 'DOMContentLoaded', initApp