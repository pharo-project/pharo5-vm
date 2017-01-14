interpreter access
isSmallFloatZero: aSmallFloat
	<inline: #always>
	self assert: (self isImmediateFloat: aSmallFloat).
	^aSmallFloat asUnsignedInteger <= self negativeSmallFloatZero