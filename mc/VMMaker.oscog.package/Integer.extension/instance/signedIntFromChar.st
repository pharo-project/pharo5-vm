*VMMaker-interpreter simulator
signedIntFromChar
	"Self is an unsigned 8-bit integer in twos-comp form"

	| shortBits |
	shortBits := self bitAnd: 16rFF.
	^(self bitAnd: 16r80) "sign bit" = 0
		ifTrue: [shortBits]
		ifFalse: [shortBits - 16r100]