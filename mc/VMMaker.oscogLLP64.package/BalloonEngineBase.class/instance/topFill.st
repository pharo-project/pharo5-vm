accessing fills
topFill
	self stackFillSize = 0
		ifTrue:[^0]
		ifFalse:[^self topFillValue].