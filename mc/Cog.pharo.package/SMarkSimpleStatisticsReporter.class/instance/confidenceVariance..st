statistics
confidenceVariance: times
	| numMeasurements |
	numMeasurements := times size.
	(numMeasurements >= 30) 
		ifTrue: [
			^ (self gaussianConfidenceFactor) * (times stdev) / (numMeasurements asFloat sqrt)].
		
	"use the students T distribution for small probe counts"
	^ (self studentsTConfidenceFactorFor: numMeasurements) * (times stdev) / (numMeasurements asFloat sqrt)