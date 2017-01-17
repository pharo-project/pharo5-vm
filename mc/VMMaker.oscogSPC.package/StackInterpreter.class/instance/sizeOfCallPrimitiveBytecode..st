compiled methods
sizeOfCallPrimitiveBytecode: methodHeader
	"Answer if the method starts with a long store temp bytecode, which indicates it has a primitive error code."
	"249		11111001	i i i i i i i i	jjjjjjjj		Call Primitive #iiiiiiii + (jjjjjjjj * 256)"
	<api>
	<inline: true>
	^objectMemory hasSpurMemoryManagerAPI
		ifTrue: [3]
		ifFalse:
			[MULTIPLEBYTECODESETS
				ifTrue: [(objectMemory headerIndicatesAlternateBytecodeSet: methodHeader)
							ifTrue: [3]
							ifFalse: [0]]
				ifFalse: [0]]