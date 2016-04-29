class Cube
  
  keyPressed = false
  separator = undefined
  rotateSpeed = .5
  arrowsRotateOffset = 5

  edge =
    front: document.getElementById 'cube-front'
    back: document.getElementById 'cube-back'
    right: document.getElementById 'cube-right'
    left: document.getElementById 'cube-left'
    top: document.getElementById 'cube-top'
    bottom: document.getElementById 'cube-bottom'

  direction =
    left: 37
    up: 38
    right: 39
    down: 40
    
  offset =
    x: 0
    y: 0


  constructor: ->
    do bindKeyPress
    do bindRotating



  bindKeyPress = ->
    document.onmousedown = (e) ->
      if not isClosestSettingsElement e.target
        if e.which is 1
          keyPressed = true

    document.onmouseup = ->
      keyPressed = false


      
  bindRotating = ->
    document.onmousemove = (e) ->
      return false if not keyPressed

      offset.x = (e.pageX - (innerWidth / 2)) * rotateSpeed
      offset.y = -((e.pageY - (innerHeight / 2))) * rotateSpeed

      do rotateCube

    document.onkeydown = (e) ->
      switch e.keyCode
        when direction.up then offset.y += arrowsRotateOffset
        when direction.down then offset.y -= arrowsRotateOffset
        when direction.left then offset.x += arrowsRotateOffset
        when direction.right then offset.x -= arrowsRotateOffset

      do rotateCube



  rotateCube = ->
    edge.front.style.transform = "rotateX(#{0 + offset.y}deg) rotateY(#{0 + offset.x}deg) translateZ(#{CUBE_SIZE / 2}px)"
    edge.back.style.transform = "rotateX(#{180 + offset.y}deg) rotateY(#{0 - offset.x}deg) translateZ(#{CUBE_SIZE / 2}px)"
    edge.right.style.transform = "rotateX(#{0 + offset.y}deg) rotateY(#{90 + offset.x}deg) translateZ(#{CUBE_SIZE / 2}px)"
    edge.left.style.transform = "rotateX(#{0 + offset.y}deg) rotateY(#{-90 + offset.x}deg) translateZ(#{CUBE_SIZE / 2}px)"
    edge.top.style.transform = "rotateX(#{90 + offset.y}deg) rotateZ(#{0 - offset.x}deg) translateZ(#{CUBE_SIZE / 2}px)"
    edge.bottom.style.transform = "rotateX(#{-90 + offset.y}deg) rotateZ(#{0 + offset.x}deg) translateZ(#{CUBE_SIZE / 2}px)"



  isClosestSettingsElement = (element) ->
    matchesSelector = element.matches or element.webkitMatchesSelector or element.mozMatchesSelector or element.msMatchesSelector

    while element
      if matchesSelector.call(element, '.settings')
        break
      element = element.parentElement
    element