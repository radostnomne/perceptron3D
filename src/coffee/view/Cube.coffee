class Cube
  
  keyPressed = false
  separator = undefined
  rotateSpeed = .5

  edge =
    front: document.getElementById 'cube-front'
    back: document.getElementById 'cube-back'
    right: document.getElementById 'cube-right'
    left: document.getElementById 'cube-left'
    top: document.getElementById 'cube-top'
    bottom: document.getElementById 'cube-bottom'



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

      x = (e.pageX - (innerWidth / 2)) * rotateSpeed
      y = -((e.pageY - (innerHeight / 2))) * rotateSpeed

      edge.front.style.transform = "rotateX(#{0 + y}deg) rotateY(#{0 + x}deg) translateZ(#{CUBE_SIZE / 2}px)"
      edge.back.style.transform = "rotateX(#{180 + y}deg) rotateY(#{0 - x}deg) translateZ(#{CUBE_SIZE / 2}px)"
      edge.right.style.transform = "rotateX(#{0 + y}deg) rotateY(#{90 + x}deg) translateZ(#{CUBE_SIZE / 2}px)"
      edge.left.style.transform = "rotateX(#{0 + y}deg) rotateY(#{-90 + x}deg) translateZ(#{CUBE_SIZE / 2}px)"
      edge.top.style.transform = "rotateX(#{90 + y}deg) rotateZ(#{0 - x}deg) translateZ(#{CUBE_SIZE / 2}px)"
      edge.bottom.style.transform = "rotateX(#{-90 + y}deg) rotateZ(#{0 + x}deg) translateZ(#{CUBE_SIZE / 2}px)"

  isClosestSettingsElement = (element) ->
    matchesSelector = element.matches or element.webkitMatchesSelector or element.mozMatchesSelector or element.msMatchesSelector

    while element
      if matchesSelector.call(element, '.settings')
        break
      element = element.parentElement
    element