generate machine code
concretizeMoveRAw
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| addressOperand reg |
	reg := operands at: 0.
	addressOperand := operands at: 1.
	(self isAnInstruction: (cogit cCoerceSimple: addressOperand to: #'AbstractInstruction *')) ifTrue:
		[addressOperand := (cogit cCoerceSimple: addressOperand to: #'AbstractInstruction *') address].
	reg = EAX ifTrue:
		[machineCode
			at: 0 put: 16rA3;
			at: 1 put: (addressOperand bitAnd: 16rFF);
			at: 2 put: (addressOperand >> 8 bitAnd: 16rFF);
			at: 3 put: (addressOperand >> 16 bitAnd: 16rFF);
			at: 4 put: (addressOperand >> 24 bitAnd: 16rFF).
			^machineCodeSize := 5].
	machineCode
		at: 0 put: 16r89;
		at: 1 put: (self mod: ModRegInd RM: 5 RO: reg);
		at: 2 put: (addressOperand bitAnd: 16rFF);
		at: 3 put: (addressOperand >> 8 bitAnd: 16rFF);
		at: 4 put: (addressOperand >> 16 bitAnd: 16rFF);
		at: 5 put: (addressOperand >> 24 bitAnd: 16rFF).
	^machineCodeSize := 6