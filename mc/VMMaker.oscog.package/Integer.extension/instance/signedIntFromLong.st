*VMMaker-interpreter simulator
signedIntFromLong
	"Self is a signed or unsigned 32-bit integer"
	| bits |
	 "If it's already 32bits, avoid computation"
	(self >= -16r80000000 and: [self <= 16r7FFFFFFF])
		ifTrue: [^self].
	bits := self bitAnd: 16rFFFFFFFF.
	(bits digitAt: 4) <= 16r7F ifTrue: [^bits].
	^bits - 16r100000000