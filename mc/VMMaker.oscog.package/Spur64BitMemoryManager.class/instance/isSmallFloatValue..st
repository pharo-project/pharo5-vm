interpreter access
isSmallFloatValue: aFloat
	<inline: true>
	<var: #aFloat type: #double>
	| exponent rawFloat |
	rawFloat := self
					cCode: [(self cCoerce: (self addressOf: aFloat) to: 'sqLong *') at: 0]
					inSmalltalk: [(aFloat at: 1) << 32 + (aFloat at: 2)].
	exponent := rawFloat >> 52 bitAnd: 16r7FF.
	^exponent > self smallFloatExponentOffset
	 	ifTrue: [exponent <= (255 + self smallFloatExponentOffset)]
		ifFalse:
			[(rawFloat bitAnd: (1 << 52 - 1)) = 0
				ifTrue: [exponent = 0]
				ifFalse: [exponent = self smallFloatExponentOffset]]