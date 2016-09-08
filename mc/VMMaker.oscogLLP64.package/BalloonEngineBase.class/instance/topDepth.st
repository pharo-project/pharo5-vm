accessing fills
topDepth
	self stackFillSize = 0
		ifTrue:[^-1]
		ifFalse:[^self topFillDepth].