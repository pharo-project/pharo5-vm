envelopeeditor compatibility
setPoints: pointList loopStart: startIndex loopEnd: endIndex

	self delta: pointList first y - 0.5 / 5.
	self highLimit: (pointList at: startIndex) y - 0.5 / 5 + 1.
	self lowLimit: pointList last y - 0.5 / 5 + 1.
	^super setPoints: pointList loopStart: startIndex loopEnd: endIndex