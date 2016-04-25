const NUM_OF_CLICKS = 5,
	SIDE_X = 20,
	SIDE_Y = 20,
	SIDE_Z = 20,
	MULTIPLIER = SIDE_X * SIDE_Y * SIDE_Z;

var blocks = new Array(),
	clickCounter = 0,
	blockIterator = 0,
	calibration = false,
	calibrated = false;

var init = function() {
	blocks.push(new Block(1, SIDE_X, SIDE_Y, SIDE_Z));
	blocks.push(new Block(2, SIDE_X, SIDE_Y, SIDE_Z));
	blocks.push(new Block(3, SIDE_X, SIDE_Y, SIDE_Z));
	blocks.push(new Block(4, SIDE_X, SIDE_Y, SIDE_Z));
	blocks.push(new Block(5, SIDE_X, SIDE_Y, SIDE_Z));
	blocks.push(new Block(6, SIDE_X, SIDE_Y, SIDE_Z));
	blocks.push(new Block(7, SIDE_X, SIDE_Y, SIDE_Z));
	blocks.push(new Block(8, SIDE_X, SIDE_Y, SIDE_Z));
};

var startCalibration = function() {
	clickCounter = 0;
    blockIterator = 0;
    
    blocks.forEach(function(item) {
    	item.clear();
    });

    console.log('Choose block ' + blocks[blockIterator].value);
    calibration = true;
    calibrated = false;
};

var stopCalibration = function() {
	calibration = false;
    console.log("The perceptron is trained!");
    calibrated = true;
};

//
var calibrate = function(x, y, z) {
	if (calibration) {
        recalculation(blocks[blockIterator], x, y, z);
        clickCounter++;
        if (clickCounter == NUM_OF_CLICKS) {
            clickCounter = 0;
            blockIterator++;
            if (blockIterator < blocks.length) {
            	console.log('Click in region ' + blocks[blockIterator].value);
            }
            if (blockIterator == blocks.length) 
            	stopCalibration();
        }
    }
};

var recalculation = function(block, x, y, z) {
    for (var i = 0; i < SIDE_X; i++) {
        for (var j = 0; j < SIDE_Y; j++) {
            for (var k = 0; k < SIDE_Z; k++) {
                block.area[i][j][k] += MULTIPLIER / ((Math.abs(i - x) + 1) * (Math.abs(j - y) + 1) * (Math.abs(k - z) + 1));
            }
        }
    }
};

var detectArea = function(x, y, z) {
	var value = '';
    var max = -1;

    blocks.forEach(function(item) {
    	if (item.area[x][y][z] > max) {
    		max = item.area[x][y][z];
    		value = item.value;
    	}
    });
    console.log('Maybe it\'s ' + value);
}

var clicking = function(e) {
	if (calibrated) {
        detectArea(e.pageX, e.pageY, e.pageZ);
    }

    if (calibration) {
        calibrate(e.pageX, e.pageY, e.pageZ);
    }
}
