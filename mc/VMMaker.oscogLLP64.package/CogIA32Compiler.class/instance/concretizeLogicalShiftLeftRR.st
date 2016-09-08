generate machine code
concretizeLogicalShiftLeftRR
	<inline: true>
	"On the x86 the only instructions that shift by the value of a
	 register require the shift count to be  in %ecx.  So we may
	 have to use swap instructions to get the count into %ecx."
	| shiftCountReg destReg regToShift |
	shiftCountReg := operands at: 0.
	destReg := operands at: 1.
	shiftCountReg = ECX ifTrue:
		[machineCode
			at: 0 put: 16rD3;
			at: 1 put: (self mod: ModReg RM: destReg RO: 4).
		 ^machineCodeSize := 2].
	regToShift := destReg == shiftCountReg
					ifTrue: [ECX]
					ifFalse: [destReg = ECX
								ifTrue: [shiftCountReg]
								ifFalse: [destReg]].
	shiftCountReg = EAX ifTrue:
		[machineCode
			at: 0 put: 16r90 + ECX; "XCHG EAX,ECX"
			at: 1 put: 16rD3;			"SAR ECX,EAX"
			at: 2 put: (self mod: ModReg RM: regToShift RO: 4);
			at: 3 put: 16r90 + ECX. "XCHG EAX,ECX"
		 ^machineCodeSize := 4].
	machineCode
		at: 0 put: 16r87;		"XCHG E?X,ECX"
		at: 1 put: (self mod: ModReg RM: ECX RO: shiftCountReg);
		at: 2 put: 16rD3;		"SAR ECX,E!X"
		at: 3 put: (self mod: ModReg RM: regToShift RO: 4);
		at: 4 put: 16r87;		"XCHG E?X,ECX"
		at: 5 put: (self mod: ModReg RM: ECX RO: shiftCountReg).
	^machineCodeSize := 6