generate machine code
concretizeMoveM32rRs
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| offset srcReg destReg skip |
	offset := operands at: 0.
	srcReg := operands at: 1.
	destReg := operands at: 2.
	machineCode at: 0 put: 16r66.
	(srcReg <= 7 and: [destReg <= 7])
		ifTrue: [skip := 0]
		ifFalse: [machineCode at: (skip := 1) put: (self rexw: false r: destReg x: 0 b: srcReg)].
	machineCode
		at: skip + 1 put: 16r0f;
		at: skip + 2 put: 16r6e.
	offset = 0 ifTrue:
		[(srcReg bitAnd: 6) ~= RSP ifTrue:
			[machineCode at: skip + 3 put: (self mod: ModRegInd RM: srcReg RO: destReg).
			 ^machineCodeSize := skip + 4].
		 (srcReg bitAnd: 7) = RSP ifTrue: "RBP & R13 fall through"
			[machineCode
				at: skip + 3 put: (self mod: ModRegInd RM: srcReg RO: destReg);
				at: skip + 4 put: (self s: SIB1 i: 4 b: srcReg).
			 ^machineCodeSize := skip + 5]].
	(self isQuick: offset) ifTrue:
		[(srcReg bitAnd: 7) ~= RSP ifTrue:
			[machineCode
				at: skip + 3 put: (self mod: ModRegRegDisp8 RM: srcReg RO: destReg);
				at: skip + 4 put: (offset bitAnd: 16rFF).
			 ^machineCodeSize := skip + 5].
		 machineCode
			at: skip + 3 put: (self mod: ModRegRegDisp8 RM: srcReg RO: destReg);
			at: skip + 4 put: (self s: SIB1 i: 4 b: srcReg);
			at: skip + 5 put: (offset bitAnd: 16rFF).
		 ^machineCodeSize := skip + 6].
	machineCode at: skip + 3 put: (self mod: ModRegRegDisp32 RM: srcReg RO: destReg).
	(srcReg bitAnd: 7) = RSP ifTrue:
		[machineCode at: skip + 4 put: (self s: SIB1 i: 4 b: srcReg).
		 skip := skip + 1].
	machineCode
		at: skip + 4 put: (offset bitAnd: 16rFF);
		at: skip + 5 put: (offset >> 8 bitAnd: 16rFF);
		at: skip + 6 put: (offset >> 16 bitAnd: 16rFF);
		at: skip + 7 put: (offset >> 24 bitAnd: 16rFF).
	^machineCodeSize := skip + 8