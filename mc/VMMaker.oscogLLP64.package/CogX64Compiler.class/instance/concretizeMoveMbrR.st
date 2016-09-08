generate machine code
concretizeMoveMbrR
	"N.B. The Cogit makes no assumption about the upper bits being set to zero because we
	 deny byteReadsZeroExtend.  The cogit will clear the register before hand if necessary."
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| srcReg offset destReg |
	offset := operands at: 0.
	srcReg := operands at: 1.
	destReg := operands at: 2.
	machineCode
		at: 0 put: (self rexR: destReg x: 0 b: srcReg);
		at: 1 put: 16r8A.
	(srcReg ~= RSP and: [srcReg ~= R12]) ifTrue:
		[(offset = 0 and: [srcReg ~= RBP and: [srcReg ~= R13]]) ifTrue:
			[machineCode
				at: 2 put: (self mod: ModRegInd RM: srcReg RO: destReg).
			 ^machineCodeSize := 3].
		(self isQuick: offset) ifTrue:
			[machineCode
				at: 2 put: (self mod: ModRegRegDisp8 RM: srcReg RO: destReg);
				at: 3 put: (offset bitAnd: 16rFF).
			 ^machineCodeSize := 4].
		machineCode
			at: 2 put: (self mod: ModRegRegDisp32 RM: srcReg RO: destReg);
			at: 3 put: (offset bitAnd: 16rFF);
			at: 4 put: (offset >> 8 bitAnd: 16rFF);
			at: 5 put: (offset >> 16 bitAnd: 16rFF);
			at: 6 put: (offset >> 24 bitAnd: 16rFF).
		^machineCodeSize := 7].
	"RSP:"
	offset = 0 ifTrue:
		[machineCode
			at: 2 put: (self mod: ModRegInd RM: srcReg RO: destReg);
			at: 3 put: (self s: SIB1 i: 4 b: srcReg).
		 ^machineCodeSize := 4].
	(self isQuick: offset) ifTrue:
		[machineCode
			at: 2 put: (self mod: ModRegRegDisp8 RM: srcReg RO: destReg);
			at: 3 put: (self s: SIB1 i: 4 b: srcReg);
			at: 4 put: (offset bitAnd: 16rFF).
		 ^machineCodeSize := 5].
	machineCode
		at: 2 put: (self mod: ModRegRegDisp32 RM: srcReg RO: destReg);
		at: 3 put: (self s: SIB1 i: 4 b: srcReg);
		at: 4 put: (offset bitAnd: 16rFF);
		at: 5 put: (offset >> 8 bitAnd: 16rFF);
		at: 6 put: (offset >> 16 bitAnd: 16rFF);
		at: 7 put: (offset >> 24 bitAnd: 16rFF).
	^machineCodeSize := 8