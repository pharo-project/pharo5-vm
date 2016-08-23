disassembly
jumpTargetPCAt: pc
	<returnTypeC: #usqInt>
	| size byte offset |
	size := self instructionSizeAt: pc.
	size = 2
		ifTrue:
			[byte := objectMemory byteAt: pc + 1.
			 offset := (byte bitAnd: 16r80) = 0 ifTrue: [byte] ifFalse: [byte - 256]]
		ifFalse:
			[byte := objectMemory byteAt: pc + size - 1.
			 offset := (byte bitAnd: 16r80) = 0 ifTrue: [byte] ifFalse: [byte - 256].
			 offset := offset << 8 + (objectMemory byteAt: pc + size - 2).
			 offset := offset << 8 + (objectMemory byteAt: pc + size - 3).
			 offset := offset << 8 + (objectMemory byteAt: pc + size - 4)].
	^pc + size + offset