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
					inSmalltalk: [self smallFloatExponentOffset
								+ (aFloat isFinite
									ifTrue:
										[aFloat = 0.0
											ifTrue: [0]
											ifFalse: [aFloat exponent + 127]]
									ifFalse: "Float nan & Float infinity exponent = -1, so mask to make > 0"
										[aFloat exponent bitAnd: SmallInteger maxVal])].
	^exponent
		between: self smallFloatExponentOffset
		and: 255 + self smallFloatExponentOffset