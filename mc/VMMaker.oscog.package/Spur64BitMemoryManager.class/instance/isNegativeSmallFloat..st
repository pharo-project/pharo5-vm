interpreter access
isNegativeSmallFloat: aSmallFloat
	<inline: true>
	self assert: (self isImmediateFloat: aSmallFloat).
	^aSmallFloat anyMask: self smallFloatSignBit