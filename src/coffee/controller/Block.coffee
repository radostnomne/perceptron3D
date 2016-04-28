class Block
  
  constructor: (_name) ->
    @name = _name
    @area = []
    do @clear

    
    
    
  clear: ->
    i = 0
    while i < ARRAY_CUBE_SIZE
      @area[i] = []
      j = 0
      while j < ARRAY_CUBE_SIZE
        @area[i][j] = []
        k = 0
        while k < ARRAY_CUBE_SIZE
          @area[i][j][k] = 0
          k++
        j++
      i++