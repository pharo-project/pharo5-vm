*VMMaker-interpreter simulator
signedInt64FromLong
	"Self is a signed or unsigned 32-bit integer"

	| sign |
	self < 0 ifTrue: [^self].
	sign := self bitAnd: 16r8000000000000000.
	sign = 0 ifTrue: [^ self].
	^ self - sign - sign