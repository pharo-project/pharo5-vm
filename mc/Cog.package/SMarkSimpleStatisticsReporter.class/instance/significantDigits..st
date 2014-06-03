statistics
significantDigits: confidenceVariance
	confidenceVariance = 0 
		ifTrue: [ ^ 2].
	
	confidenceVariance >= 10
		ifTrue: [ ^ 0].
	
	^ 1 - (confidenceVariance log floor)