generate machine code
concretizeMoveAbR
	"N.B. The Cogit makes no assumption about the upper bits being set to zero because we
	 deny byteReadsZeroExtend.  The cogit will clear the register before hand if necessary."
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| addressOperand reg offset save0 save1 |
	addressOperand := operands at: 0.
	(self isAnInstruction: (cogit cCoerceSimple: addressOperand to: #'AbstractInstruction *')) ifTrue:
		[addressOperand := (cogit cCoerceSimple: addressOperand to: #'AbstractInstruction *') address].
	(self isAddressRelativeToVarBase: addressOperand) ifTrue:
		[save0 := operands at: 0.
		 save1 := operands at: 1.
		 operands
			at: 0 put: addressOperand - cogit varBaseAddress;
			at: 1 put: RBX;
			at: 2 put: save1.
		 self concretizeMoveMbrR.
		 operands
			at: 0 put: save0;
			at: 1 put: save1;
			at: 2 put: 0.
		^machineCodeSize].
	reg := operands at: 1.
	reg = RAX
		ifTrue: [offset := 0]
		ifFalse:
			[machineCode
				at: 0 put: (self rexR: 0 x: 0 b: reg);
				at: 1 put: 16r90 + (reg \\ 8).
			 offset := 2].
	machineCode
		at: 0 + offset put: 16r48;
		at: 1 + offset put: 16rA0;
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