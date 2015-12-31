inline cacheing
targetFromITypeAtAddress: mcpc
	<var: #offset type: #usqInt>
	<var: #mcpc type: #usqInt>
	<returnTypeC: #usqInt>
	| offset |
	offset := (objectMemory longAt: mcpc) bitAnd: 16rFFFF.
	self cCode: '' inSmalltalk: [offset >= 16r8000 ifTrue: [offset := offset - 16r10000]].
	offset := offset << 2.
	^mcpc + offset + OneInstruction. "Offset is relative to the delay slot"