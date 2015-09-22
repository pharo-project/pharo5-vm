generate machine code
concretizeArithmeticShiftRightRR
	"On the x64 the only instructions that shift by the value of a
	 register require the shift count to be  in %ecx.  So we may
	 have to use swap instructions to get the count into %ecx."
	<inline: true>
	| shiftCountReg destReg regToShift |
	shiftCountReg := self concreteRegister: (operands at: 0).
	destReg := self concreteRegister: (operands at: 1).
	shiftCountReg = RCX ifTrue:
		[machineCode
			at: 0 put: (self rexR: 0 x: 0 b: destReg);
			at: 1 put: 16rD3;
			at: 2 put: (self mod: ModReg RM: destReg RO: 7).
		 ^machineCodeSize := 3].
	regToShift := destReg = shiftCountReg
					ifTrue: [RCX]
					ifFalse: [destReg = RCX
								ifTrue: [shiftCountReg]
								ifFalse: [destReg]].
	shiftCountReg = RAX ifTrue:
		[machineCode
			at: 0 put: 16r48;
			at: 1 put: 16r90 + RCX; "XCHG RAX,RCX"
			at: 2 put: (self rexR: 0 x: 0 b: regToShift);
			at: 3 put: 16rD3;			"SAR RCX,RAX"
			at: 4 put: (self mod: ModReg RM: regToShift RO: 7);
			at: 5 put: 16r48;
			at: 6 put: 16r90 + RCX. "XCHG RAX,RCX"
		 ^machineCodeSize := 7].
	machineCode
		at: 0 put: (self rexR: shiftCountReg x: 0 b: RCX);		"XCHG R?X,RCX"
		at: 1 put: 16r87;
		at: 2 put: (self mod: ModReg RM: RCX RO: shiftCountReg);
		at: 3 put: (self rexR: 0 x: 0 b: regToShift);			"SAR RCX,R!X"
		at: 4 put: 16rD3;
		at: 5 put: (self mod: ModReg RM: regToShift RO: 7);
		at: 6 put: (self rexR: shiftCountReg x: 0 b: RCX);		"XCHG R?X,RCX"
		at: 7 put: 16r87;
		at: 8 put: (self mod: ModReg RM: RCX RO: shiftCountReg).
	^machineCodeSize := 9