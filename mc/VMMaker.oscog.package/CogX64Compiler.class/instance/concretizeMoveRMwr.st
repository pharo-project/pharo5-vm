generate machine code
concretizeMoveRMwr
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| srcReg offset destReg |
	srcReg := operands at: 0.
	offset := operands at: 1.
	destReg := operands at: 2.
	machineCode
		at: 0 put: (self rexR: srcReg x: 0 b: destReg);
		at: 1 put: 16r89.
	(destReg ~= RSP and: [destReg ~= R12]) ifTrue:
		[(offset = 0 and: [destReg ~= RBP and: [destReg ~= R13]]) ifTrue:
			[machineCode
				at: 2 put: (self mod: ModRegInd RM: destReg RO: srcReg).
			 ^machineCodeSize := 3].
		 (self isQuick: offset) ifTrue:
			[machineCode
				at: 2 put: (self mod: ModRegRegDisp8 RM: destReg RO: srcReg);
				at: 3 put: (offset bitAnd: 16rFF).
			 ^machineCodeSize := 4].
		machineCode
			at: 2 put: (self mod: ModRegRegDisp32 RM: destReg RO: srcReg);
			at: 3 put: (offset bitAnd: 16rFF);
			at: 4 put: (offset >> 8 bitAnd: 16rFF);
			at: 5 put: (offset >> 16 bitAnd: 16rFF);
			at: 6 put: (offset >> 24 bitAnd: 16rFF).
		^machineCodeSize := 7].
	"RSP:"
	offset = 0 ifTrue:
		[machineCode
			at: 2 put: (self mod: ModRegInd RM: destReg RO: srcReg);
			at: 3 put: (self s: SIB1 i: 4 b: destReg).
		 ^machineCodeSize := 4].
	(self isQuick: offset) ifTrue:
		[machineCode
			at: 2 put: (self mod: ModRegRegDisp8 RM: destReg RO: srcReg);
			at: 3 put: (self s: SIB1 i: 4 b: destReg);
			at: 4 put: (offset bitAnd: 16rFF).
		 ^machineCodeSize := 5].
	machineCode
		at: 2 put: (self mod: ModRegRegDisp32 RM: destReg RO: srcReg);
		at: 3 put: (self s: SIB1 i: 4 b: destReg);
		at: 4 put: (offset bitAnd: 16rFF);
		at: 5 put: (offset >> 8 bitAnd: 16rFF);
		at: 6 put: (offset >> 16 bitAnd: 16rFF);
		at: 7 put: (offset >> 24 bitAnd: 16rFF).
	^machineCodeSize := 8