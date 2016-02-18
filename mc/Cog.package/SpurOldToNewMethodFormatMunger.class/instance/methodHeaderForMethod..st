munging
methodHeaderForMethod: method
	^heap integerObjectOf:
		   (method numArgs << 24)
		+ (method numTemps << 18)
		+ (method frameSize > method class smallFrameSize ifTrue: [1 << 17] ifFalse: [0])
		+ (method primitive > 0 ifTrue: [1 << 16] ifFalse: [0])
		+ method numLiterals