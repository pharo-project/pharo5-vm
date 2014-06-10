*VMMaker-interpreter simulator
signedIntFromLong
	"Self is a signed or unsigned 32-bit integer"

	| sign |
	self < 0 ifTrue: [^self].
	sign := self bitAnd: 16r80000000.
	sign = 0 ifTrue: [^ self].
	^ self - sign - sign