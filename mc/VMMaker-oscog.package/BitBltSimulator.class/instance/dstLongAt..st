debug support
dstLongAt: dstIndex

	interpreterProxy isInterpreterProxy
		ifTrue:[^dstIndex long32At: 0].
	((dstIndex anyMask: 3) or:[dstIndex + 4 < destBits or:[
		dstIndex > (destBits + (destPitch * destHeight))]])
			ifTrue:[self error:'Out of bounds'].
	^self long32At: dstIndex