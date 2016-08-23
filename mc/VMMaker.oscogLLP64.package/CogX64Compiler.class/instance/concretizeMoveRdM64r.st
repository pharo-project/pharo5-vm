generate machine code
concretizeMoveRdM64r
	<inline: true>
	| offset srcReg destReg skip |
	srcReg := operands at: 0.
	offset := operands at: 1.
	destReg := operands at: 2.
	machineCode at: 0 put: 16r66.
	(srcReg <= 7 and: [destReg <= 7])
		ifTrue: [skip := 0]
		ifFalse: [machineCode at: (skip := 1) put: (self rexw: false r: srcReg x: 0 b: destReg)].
	machineCode
		at: skip + 1 put: 16r0f;
		at: skip + 2 put: 16rd6.
	offset = 0 ifTrue:
		[(destReg bitAnd: 6) ~= RSP ifTrue:
			[machineCode at: skip + 3 put: (self mod: ModRegInd RM: destReg RO: srcReg).
			 ^machineCodeSize := skip + 4].
		 (destReg bitAnd: 7) = RSP ifTrue: "RBP & R13 fall through"
			[machineCode
				at: skip + 3 put: (self mod: ModRegInd RM: destReg RO: srcReg);
				at: skip + 4 put: (self s: SIB1 i: 4 b: destReg).
			 ^machineCodeSize := skip + 5]].
	(self isQuick: offset) ifTrue:
		[(destReg bitAnd: 7) ~= RSP ifTrue:
			[machineCode
				at: skip + 3 put: (self mod: ModRegRegDisp8 RM: destReg RO: srcReg);
				at: skip + 4 put: (offset bitAnd: 16rFF).
			 ^machineCodeSize := skip + 5].
		 machineCode
			at: skip + 3 put: (self mod: ModRegRegDisp8 RM: destReg RO: srcReg);
			at: skip + 4 put: (self s: SIB1 i: 4 b: destReg);
			at: skip + 5 put: (offset bitAnd: 16rFF).
		 ^machineCodeSize := skip + 6].
	machineCode at: skip + 3 put: (self mod: ModRegRegDisp32 RM: destReg RO: srcReg).
	(destReg bitAnd: 7) = RSP ifTrue:
		[machineCode at: skip + 4 put: (self s: SIB1 i: 4 b: destReg).
		 skip := skip + 1].
	machineCode
		at: skip + 4 put: (offset bitAnd: 16rFF);
		at: skip + 5 put: (offset >> 8 bitAnd: 16rFF);
		at: skip + 6 put: (offset >> 16 bitAnd: 16rFF);
		at: skip + 7 put: (offset >> 24 bitAnd: 16rFF).
	^machineCodeSize := skip + 8