*VMMaker-interpreter simulator
signedIntFromLong
	"Self is a signed or unsigned 32-bit integer"

	| bits |
	(self >= SmallInteger minVal and: [self <= SmallInteger maxVal]) ifTrue: "These are known to be SmallIntegers..."
		[^self].
	bits := self bitAnd: 16rFFFFFFFF.
	(bits digitAt: 4) <= 16r7F ifTrue: [^bits].
	^bits - 16r100000000