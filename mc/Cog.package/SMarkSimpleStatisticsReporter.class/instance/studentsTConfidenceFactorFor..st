statistics
studentsTConfidenceFactorFor: aNumberOfMeasurements
	"used for small probe counts < 30"
	"the students T distribution sucks to calculate since the value depends on the probeCout"
	"these values are for a confidence interval of ~90%"
	| values |
	values := Array new: 30.
	values at: 1  put: 6.314.
	values at: 2  put: 2.920.
	values at: 3  put: 2.353.
	values at: 4  put: 2.132.
	values at: 5  put: 2.015.
	values at: 6  put: 1.943.
	values at: 7  put: 1.895.
	values at: 8  put: 1.860.
	values at: 9  put: 1.833.
	values at: 10 put: 1.812.
	values at: 11 put: 1.796.
	values at: 12 put: 1.782.
	values at: 13 put: 1.771.
	values at: 14 put: 1.761.
	values at: 15 put: 1.753.
	values at: 16 put: 1.746.
	values at: 17 put: 1.740.
	values at: 18 put: 1.734.
	values at: 19 put: 1.729.
	values at: 20 put: 1.725.
	values at: 21 put: 1.721.
	values at: 22 put: 1.717.
	values at: 23 put: 1.714.
	values at: 24 put: 1.711.
	values at: 25 put: 1.708.
	values at: 26 put: 1.706.
	values at: 27 put: 1.703.
	values at: 28 put: 1.701.
	values at: 29 put: 1.699.
	values at: 30 put: 1.697.
	^ values at: aNumberOfMeasurements.
	