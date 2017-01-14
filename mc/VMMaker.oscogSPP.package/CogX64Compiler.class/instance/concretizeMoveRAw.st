generate machine code
concretizeMoveRAw
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| addressOperand reg offset save1 |
	reg := operands at: 0.
	addressOperand := operands at: 1.
	(self isAnInstruction: (cogit cCoerceSimple: addressOperand to: #'AbstractInstruction *')) ifTrue:
		[addressOperand := (cogit cCoerceSimple: addressOperand to: #'AbstractInstruction *') address].
	(self isAddressRelativeToVarBase: addressOperand) ifTrue:
		[save1 := operands at: 1.
		 operands
			at: 1 put: addressOperand - cogit varBaseAddress;
			at: 2 put: RBX.
		 self concretizeMoveRMwr.
		 operands
			at: 1 put: save1;
			at: 2 put: 0.
		^machineCodeSize].
	reg = RAX
		ifTrue: [offset := 0]
		ifFalse:
			[machineCode
				at: 0 put: (self rexR: 0 x: 0 b: reg);
				at: 1 put: 16r90 + (reg \\ 8).
			 offset := 2].
	machineCode
		at: 0 + offset put: 16r48;
		at: 1 + offset put: 16rA3;
		at: 2 + offset put: (addressOperand bitAnd: 16rFF);
		at: 3 + offset put: (addressOperand >> 8 bitAnd: 16rFF);
		at: 4 + offset put: (addressOperand >> 16 bitAnd: 16rFF);
		at: 5 + offset put: (addressOperand >> 24 bitAnd: 16rFF);
		at: 6 + offset put: (addressOperand >> 32 bitAnd: 16rFF);
		at: 7 + offset put: (addressOperand >> 40 bitAnd: 16rFF);
		at: 8 + offset put: (addressOperand >> 48 bitAnd: 16rFF);
		at: 9 + offset put: (addressOperand >> 56 bitAnd: 16rFF).
	reg = RAX ifTrue:
		[^machineCodeSize := 10].
	machineCode
		at: 12 put: (machineCode at: 0);
		at: 13 put: (machineCode at: 1).
	^machineCodeSize := 14