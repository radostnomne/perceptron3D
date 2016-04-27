'use strict'

document.addEventListener 'DOMContentLoaded', ->
  CUBE_SIZE = 200

  new Cube CUBE_SIZE
  new Configurator CUBE_SIZE