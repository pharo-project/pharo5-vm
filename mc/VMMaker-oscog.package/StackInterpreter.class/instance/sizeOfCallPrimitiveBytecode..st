compiled methods
sizeOfCallPrimitiveBytecode: methodHeader
	"Answer if the method starts with a long store temp bytecode, which indicates it has a primitive error code."
	"249		11111001	i i i i i i i i	jjjjjjjj		Call Primitive #iiiiiiii + (jjjjjjjj * 256)"
	<api>
	<inline: true>
	^self
		cppIf: MULTIPLEBYTECODESETS
		ifTrue: [(self headerIndicatesAlternateBytecodeSet: methodHeader)
					ifTrue: [3]
					ifFalse: [0]]
		ifFalse: [0]