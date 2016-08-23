*VMMaker-interpreter simulator
signedIntFromLong
	"Self is a signed or unsigned 32-bit integer"

	| bits |
	(self >= -1073741824 and: [self <= 1073741823]) ifTrue: "These are known to be SmallIntegers..."
		[^self].
	bits := self bitAnd: 16rFFFFFFFF.
	(bits digitAt: 4) <= 16r7F ifTrue: [^bits].
	^bits - 16r100000000