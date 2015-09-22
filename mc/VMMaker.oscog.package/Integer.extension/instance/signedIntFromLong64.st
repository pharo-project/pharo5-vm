*VMMaker-interpreter simulator
signedIntFromLong64
	"Self is a signed or unsigned 64-bit integer"

	| sign |
	self < 0 ifTrue: [^self].
	sign := self bitAnd: 16r8000000000000000.
	sign = 0 ifTrue: [^self].
	^self - sign - sign