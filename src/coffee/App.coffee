'use strict'

initApp = ->
  CUBE_SIZE = 200

  new Cube CUBE_SIZE
  new Configurator CUBE_SIZE



document.addEventListener 'DOMContentLoaded', initApp