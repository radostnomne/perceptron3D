class Cube
  keyPressed = false
  separator = undefined
  CUBE_SIZE = 0

  content = document.getElementById 'content'

  edge =
    front: document.getElementById 'cube-front'
    back: document.getElementById 'cube-back'
    right: document.getElementById 'cube-right'
    left: document.getElementById 'cube-left'
    top: document.getElementById 'cube-top'
    bottom: document.getElementById 'cube-bottom'

  constructor: (size) ->
    CUBE_SIZE = size
    do bindKeyPress
    do bindRotating

  bindKeyPress = ->
    content.onmousedown = (e) ->
      if e.which is 1
        keyPressed = true

    content.onmouseup = ->
      keyPressed = false

  bindRotating = ->
    content.onmousemove = (e) ->
      return false if not keyPressed

      x = e.clientX - (innerWidth / 2)
      y = -(e.clientY - (innerHeight / 2))

      edge.front.style.transform = "rotateX(#{0 + y}deg) rotateY(#{0 + x}deg) translateZ(#{CUBE_SIZE / 2}px)"
      edge.back.style.transform = "rotateX(#{180 + y}deg) rotateY(#{0 - x}deg) translateZ(#{CUBE_SIZE / 2}px)"
      edge.right.style.transform = "rotateX(#{0 + y}deg) rotateY(#{90 + x}deg) translateZ(#{CUBE_SIZE / 2}px)"
      edge.left.style.transform = "rotateX(#{0 + y}deg) rotateY(#{-90 + x}deg) translateZ(#{CUBE_SIZE / 2}px)"
      edge.top.style.transform = "rotateX(#{90 + y}deg) rotateZ(#{0 - x}deg) translateZ(#{CUBE_SIZE / 2}px)"
      edge.bottom.style.transform = "rotateX(#{-90 + y}deg) rotateZ(#{0 + x}deg) translateZ(#{CUBE_SIZE / 2}px)"