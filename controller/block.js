function Block(value, x, y, z) {
	this.value = value;
	this.area = null;
	this.clear = function(x, y, z) {
		this.area = new Array();
  		for(var i = 0; i < x; i++) {
    		this.area[i] = new Array();
    		for(var j = 0; j < y; j++){
    			this.area[i][j] = new Array();
    			for (var k = 0; k < z; k++) {
      				this.area[i][j][k] = 0;
    			}
    		}
  		}
	}

	this.print = function() {
		for (var i = 0; i < x; i++) {
			for (var j = 0; j < y; j++) {
				for (var k = 0; k < z; k++) {
					console.log(this.area[i][j][k]);
				}
			}
		}
	}
	this.clear(x, y, z);
}