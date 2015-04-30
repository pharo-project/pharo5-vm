disassembly
jumpTargetPCAt: pc
	<returnTypeC: #usqInt>
	| operand word |
	word := objectMemory long32At: pc.
	operand := word bitAnd: 16rFFFFFF.
	(operand anyMask: 16r800000) ifTrue:
		[operand := operand - 16r1000000].
	^self
		cCode: [operand * 4 + pc + 8]
		inSmalltalk: [operand * 4 + pc + 8 bitAnd: cogit addressSpaceMask]