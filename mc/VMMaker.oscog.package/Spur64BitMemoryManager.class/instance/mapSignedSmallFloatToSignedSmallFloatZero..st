interpreter access
mapSignedSmallFloatToSignedSmallFloatZero: aSmallFloat
	<inline: true>
	self assert: (self isImmediateFloat: aSmallFloat).
	^aSmallFloat bitAnd: self smallFloatSignBit + self tagMask