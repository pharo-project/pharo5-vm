debug support
srcLongAt: srcIndex

	interpreterProxy isInterpreterProxy
		ifTrue:[^srcIndex long32At: 0].
	((srcIndex anyMask: 3) or:[srcIndex + 4 < sourceBits or:[
		srcIndex > (sourceBits + (sourcePitch * sourceHeight))]])
			ifTrue:[self error:'Out of bounds'].
	^self long32At: srcIndex