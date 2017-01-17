generate machine code
concretizeMoveM32rR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| offset srcReg destReg skip |
	offset := operands at: 0.
	srcReg := operands at: 1.
	destReg := operands at: 2.
	(srcReg <= 7 and: [destReg <= 7])
		ifTrue: [skip := 0]
		ifFalse: [skip := 1. machineCode at: 0 put: (self rexw: false r: destReg x: 0 b: srcReg)].
	machineCode
		at: skip + 0 put: 16r8b.
	offset = 0 ifTrue:
		[(srcReg bitAnd: 6) ~= RSP ifTrue:
			[machineCode at: skip + 1 put: (self mod: ModRegInd RM: srcReg RO: destReg).
			 ^machineCodeSize := skip + 2].
		 (srcReg bitAnd: 7) = RSP ifTrue: "RBP & R13 fall through"
			[machineCode
				at: skip + 1 put: (self mod: ModRegInd RM: srcReg RO: destReg);
				at: skip + 2 put: (self s: SIB1 i: 4 b: srcReg).
			 ^machineCodeSize := skip + 3]].
	(self isQuick: offset) ifTrue:
		[(srcReg bitAnd: 7) ~= RSP ifTrue:
			[machineCode
				at: skip + 1 put: (self mod: ModRegRegDisp8 RM: srcReg RO: destReg);
				at: skip + 2 put: (offset bitAnd: 16rFF).
			 ^machineCodeSize := skip + 3].
		 machineCode
			at: skip + 1 put: (self mod: ModRegRegDisp8 RM: srcReg RO: destReg);
			at: skip + 2 put: (self s: SIB1 i: 4 b: srcReg);
			at: skip + 3 put: (offset bitAnd: 16rFF).
		 ^machineCodeSize := skip + 4].
	machineCode at: skip + 1 put: (self mod: ModRegRegDisp32 RM: srcReg RO: destReg).
	(srcReg bitAnd: 7) = RSP ifTrue:
		[machineCode at: skip + 2 put: (self s: SIB1 i: 4 b: srcReg).
		 skip := skip + 1].
	machineCode
		at: skip + 2 put: (offset bitAnd: 16rFF);
		at: skip + 3 put: (offset >> 8 bitAnd: 16rFF);
		at: skip + 4 put: (offset >> 16 bitAnd: 16rFF);
		at: skip + 5 put: (offset >> 24 bitAnd: 16rFF).
	^machineCodeSize := skip + 6