*VMMaker-bit manipulation
>>> shiftAmount  "right shift, but causes CCodeGenerator to generate a signed shift"
	shiftAmount < 0 ifTrue: [self error: 'negative arg'].
	^self bitShift: 0 - shiftAmount