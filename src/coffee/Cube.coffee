class Cube
  keyPressed = false

  edge =
    front: document.getElementById 'cube-front'
    back: document.getElementById 'cube-back'
    right: document.getElementById 'cube-right'
    left: document.getElementById 'cube-left'
    top: document.getElementById 'cube-top'
    bottom: document.getElementById 'cube-bottom'

  separator =
    x: document.getElementById 'cube-separator-x'
    y: document.getElementById 'cube-separator-y'
  
  constructor: ->
    do bindKeyPress
    do bindRotating

  bindKeyPress = ->
    document.onmousedown = (e) ->
      if e.which is 1
        keyPressed = true

    document.onmouseup = ->
      keyPressed = false

  bindRotating = ->
    document.onmousemove = (e) ->
      return false if not keyPressed

      x = e.clientX - (innerWidth / 2)
      y = -(e.clientY - (innerHeight / 2))

      edge.front.style.transform = "rotateX(#{0 + y}deg) rotateY(#{0 + x}deg) translateZ(100px)"
      edge.back.style.transform = "rotateX(#{180 + y}deg) rotateY(#{0 - x}deg) translateZ(100px)"
      edge.right.style.transform = "rotateX(#{0 + y}deg) rotateY(#{90 + x}deg) translateZ(100px)"
      edge.left.style.transform = "rotateX(#{0 + y}deg) rotateY(#{-90 + x}deg) translateZ(100px)"
      edge.top.style.transform = "rotateX(#{90 + y}deg) rotateZ(#{0 - x}deg) translateZ(100px)"
      edge.bottom.style.transform = "rotateX(#{-90 + y}deg) rotateZ(#{0 + x}deg) translateZ(100px)"

      separator.x.style.transform = "rotateX(#{0 + y}deg) rotateY(#{0 + x}deg)"
      separator.y.style.transform = "rotateX(#{90 + y}deg) rotateZ(#{0 - x}deg)"