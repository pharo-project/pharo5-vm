accessing fills
topRightX
	self stackFillSize = 0
		ifTrue:[^999999999]
		ifFalse:[^self topFillRightX].