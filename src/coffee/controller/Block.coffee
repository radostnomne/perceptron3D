class Block
  value = undefined
  size = undefined
  area = undefined
  
  constructor = (_value, _size) ->
    value = _value
    size = _size
    do @clear

  clear: ->
    area = new Array

    i = 0
    while i < size.x
      area[i] = new Array
      j = 0
      while j < size.y
        area[i][j] = new Array
        k = 0
        while k < size.z
          area[i][j][k] = 0
          k++
        j++
      i++