generate machine code
concretizeMoveAbR
	"N.B. we zero-extend because we state byteReadsZeroExtend."
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| addressOperand reg |
	addressOperand := operands at: 0.
	(self isAnInstruction: (cogit cCoerceSimple: addressOperand to: #'AbstractInstruction *')) ifTrue:
		[addressOperand := (cogit cCoerceSimple: addressOperand to: #'AbstractInstruction *') address].
	reg := operands at: 1.
	machineCode
		at: 0 put: 16r0F;
		at: 1 put: 16rB6;
		at: 2 put: (self mod: ModRegInd RM: 5 RO: reg);
		at: 3 put: (addressOperand bitAnd: 16rFF);
		at: 4 put: (addressOperand >> 8 bitAnd: 16rFF);
		at: 5 put: (addressOperand >> 16 bitAnd: 16rFF);
		at: 6 put: (addressOperand >> 24 bitAnd: 16rFF).
	^machineCodeSize := 7