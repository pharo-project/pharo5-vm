debug support
dstLongAt: dstIndex put: value

	interpreterProxy isInterpreterProxy
		ifTrue:[^dstIndex long32At: 0 put: value].
	((dstIndex anyMask: 3) or:[dstIndex < destBits or:[
		dstIndex >= (destBits + (destPitch * destHeight))]])
			ifTrue:[self error:'Out of bounds'].
	^self long32At: dstIndex put: value