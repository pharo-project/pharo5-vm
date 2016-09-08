generate machine code
concretizeMoveA32R
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| addressOperand reg offset |
	addressOperand := operands at: 0.
	(self isAnInstruction: (cogit cCoerceSimple: addressOperand to: #'AbstractInstruction *')) ifTrue:
		[addressOperand := (cogit cCoerceSimple: addressOperand to: #'AbstractInstruction *') address].
	reg := operands at: 1.
	reg = RAX
		ifTrue: [offset := 0]
		ifFalse:
			[machineCode
				at: 0 put: (self rexR: 0 x: 0 b: reg);
				at: 1 put: 16r90 + (reg \\ 8).
			 offset := 2].
	machineCode
		at: 0 + offset put: 16rA1;
		at: 1 + offset put: (addressOperand bitAnd: 16rFF);
		at: 2 + offset put: (addressOperand >> 8 bitAnd: 16rFF);
		at: 3 + offset put: (addressOperand >> 16 bitAnd: 16rFF);
		at: 4 + offset put: (addressOperand >> 24 bitAnd: 16rFF);
		at: 5 + offset put: (addressOperand >> 32 bitAnd: 16rFF);
		at: 6 + offset put: (addressOperand >> 40 bitAnd: 16rFF);
		at: 7 + offset put: (addressOperand >> 48 bitAnd: 16rFF);
		at: 8 + offset put: (addressOperand >> 56 bitAnd: 16rFF).
	reg = RAX ifTrue:
		[^machineCodeSize := 9].
	machineCode
		at: 11 put: (machineCode at: 0);
		at: 12 put: (machineCode at: 1).
	^machineCodeSize := 13