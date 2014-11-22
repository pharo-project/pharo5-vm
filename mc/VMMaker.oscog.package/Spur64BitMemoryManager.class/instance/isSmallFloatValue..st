interpreter access
isSmallFloatValue: aFloat
	<inline: true>
	<var: #aFloat type: #double>
	| exponent |
	exponent := self
					cCode:
						[| rawFloat |
						 rawFloat := (self cCoerce: (self addressOf: aFloat) to: 'sqLong *') at: 0.
						 rawFloat >> 52 bitAnd: 16r7FF]
					inSmalltalk: [aFloat exponent].
	^exponent between: -127 and: 127