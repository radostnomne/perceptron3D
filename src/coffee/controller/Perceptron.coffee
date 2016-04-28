class Perceptron

  COUNTER = 5
  MULTIPLIER = Math.pow ARRAY_CUBE_SIZE, 3

  blocks = []
  markCounter = 0
  blockIterator = 0
  calibration = false
  calibrated = false

  configurator = undefined
  infoElement = document.getElementById 'info'
  calibrationButton = document.getElementById 'calibration'
  buttonProgressClass = 'button_progress'
  progressElement = document.getElementById 'progress'
  currentProgressElement = document.getElementById 'current-progress'
  progressCounter = 1



  constructor: (_configurator) ->
    configurator = _configurator

    for i in [1..8]
      blocks.push new Block i

    do bindEvents



  startCalibration = ->
    markCounter = 0
    blockIterator = 0

    blocks.forEach (block) ->
      do block.clear

    calibration = true
    calibrated = false
    progressCounter = 1
    progressElement.style.width = 0
    do configurator.hideGhosts

    showMessage "Select block < #{blocks[blockIterator].name} >"
    showMessage "Finished: 0 of #{COUNTER}, Total: 0 of #{(blocks.length) * COUNTER}", true



  stopCalibration = ->
    calibration = false
    calibrated = true

    calibrationButton.classList.remove buttonProgressClass
    calibrationButton.textContent = 'Start calibration'

    showMessage 'The perceptron is trained!'
    showMessage '', true



  calibrate = ->
    if calibration
      recalculation blocks[blockIterator], do configurator.getMarkPosition
      markCounter++

      progressElement.style.width = "#{Math.round((progressCounter / (blocks.length * COUNTER)) * 100)}%"
      showMessage "Finished: #{markCounter} of #{COUNTER}, Total: #{progressCounter} of #{(blocks.length) * COUNTER}", true
      progressCounter++

      if markCounter == COUNTER
        markCounter = 0
        blockIterator++

        if blockIterator < blocks.length
          showMessage "Select block < #{blocks[blockIterator].name} >"

        if blockIterator == blocks.length
          do stopCalibration

        configurator.setGhostPosition(blockIterator - 1)



  recalculation = (block, point) ->
    point = convertPoint point

    i = 0
    while i < ARRAY_CUBE_SIZE
      j = 0
      while j < ARRAY_CUBE_SIZE
        k = 0
        while k < ARRAY_CUBE_SIZE
          block.area[i][j][k] += Math.floor MULTIPLIER / ((Math.abs(i - point.x) + 1) * (Math.abs(j - point.y) + 1) * (Math.abs(k - point.z) + 1))
          k++
        j++
      i++



  detectArea = ->
    name = ''
    max = -1
    point = convertPoint do configurator.getMarkPosition

    blocks.forEach (block) ->
      if block.area[point.x][point.y][point.z] > max
        max = block.area[point.x][point.y][point.z]
        name = block.name

    showMessage "Maybe it\'s <#{name}>"



  convertPoint = (point) ->
    result = {}
    for dot of point
      result[dot] = Math.floor Math.abs((point[dot] - 1) / CUBE_SIZE * ARRAY_CUBE_SIZE)
    result



  showMessage = (message, toProgress) ->
    if toProgress
      currentProgressElement.textContent = message
    else
      infoElement.textContent = message



  bindEvents = ->
    document.getElementById('set').addEventListener 'click', ->
      if calibrated
        do detectArea

      if calibration
        do calibrate

    calibrationButton.addEventListener 'click', ->
      if not calibration
        this.classList.add buttonProgressClass
        this.textContent = 'Calibrating...'
        do startCalibration