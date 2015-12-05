inline cacheing
targetFromITypeAtAddress: mcpc
	| offset |
	offset := (objectMemory longAt: mcpc) bitAnd: 16rFFFF.
	offset >= 16r8000 ifTrue: [offset := offset - 16r10000].
	offset := offset << 2.
	^mcpc + offset + OneInstruction. "Offset is relative to the delay slot"