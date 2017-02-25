*VMMaker-interpreter simulator
signedIntFromLong64
	"Self is a signed or unsigned 64-bit integer"

	| bits |
	"This case is handled by the SmallInteger subclass..."
	"(self >= -1073741824 and: [self <= 1073741823]) ifTrue:
		[^self]."
	bits := self bitAnd: 16rFFFFFFFFFFFFFFFF.
	(bits digitAt: 8) <= 16r7F ifTrue: [^bits].
	^bits - 16r10000000000000000