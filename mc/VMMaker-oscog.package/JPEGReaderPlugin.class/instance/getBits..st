stream support
getBits: requestedBits
	| value |
	requestedBits > jsBitCount ifTrue:[
		self fillBuffer.
		requestedBits > jsBitCount ifTrue:[^-1]].
	jsBitCount := jsBitCount - requestedBits.
	value := jsBitBuffer >> jsBitCount.
	jsBitBuffer := jsBitBuffer bitAnd: (1 << jsBitCount) -1.
	^ value