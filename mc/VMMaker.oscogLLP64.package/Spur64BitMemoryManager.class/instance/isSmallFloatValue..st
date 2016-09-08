interpreter access
isSmallFloatValue: aFloat
	<inline: true>
	<var: #rawFloat type: #usqLong>
	<var: #aFloat type: #double>
	| exponent rawFloat |
	self
		cCode: [self mem: (self addressOf: rawFloat) cp: (self addressOf: aFloat) y: (self sizeof: rawFloat)]
		inSmalltalk: [rawFloat := (aFloat at: 1) << 32 + (aFloat at: 2)].
	exponent := rawFloat >> self smallFloatMantissaBits bitAnd: 16r7FF.
	^exponent > self smallFloatExponentOffset
	 	ifTrue: [exponent <= (255 + self smallFloatExponentOffset)]
		ifFalse:
			[(rawFloat bitAnd: (1 << self smallFloatMantissaBits - 1)) = 0
				ifTrue: [exponent = 0]
				ifFalse: [exponent = self smallFloatExponentOffset]]