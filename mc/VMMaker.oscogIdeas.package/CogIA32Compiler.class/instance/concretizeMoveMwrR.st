generate machine code
concretizeMoveMwrR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| srcReg offset destReg |
	offset := operands at: 0.
	srcReg := operands at: 1.
	destReg := operands at: 2.
	srcReg ~= ESP ifTrue:
		[(offset = 0 and: [srcReg ~= EBP]) ifTrue:
			[machineCode
				at: 0 put: 16r8B;
				at: 1 put: (self mod: ModRegInd RM: srcReg RO: destReg).
			 ^machineCodeSize := 2].
		(self isQuick: offset) ifTrue:
			[machineCode
				at: 0 put: 16r8B;
				at: 1 put: (self mod: ModRegRegDisp8 RM: srcReg RO: destReg);
				at: 2 put: (offset bitAnd: 16rFF).
			 ^machineCodeSize := 3].
		machineCode
			at: 0 put: 16r8B;
			at: 1 put: (self mod: ModRegRegDisp32 RM: srcReg RO: destReg);
			at: 2 put: (offset bitAnd: 16rFF);
			at: 3 put: (offset >> 8 bitAnd: 16rFF);
			at: 4 put: (offset >> 16 bitAnd: 16rFF);
			at: 5 put: (offset >> 24 bitAnd: 16rFF).
		^machineCodeSize := 6].
	"ESP:"
	offset = 0 ifTrue:
		[machineCode
			at: 0 put: 16r8B;
			at: 1 put: (self mod: ModRegInd RM: srcReg RO: destReg);
			at: 2 put: (self s: SIB1 i: 4 b: srcReg).
		 ^machineCodeSize := 3].
	(self isQuick: offset) ifTrue:
		[machineCode
			at: 0 put: 16r8B;
			at: 1 put: (self mod: ModRegRegDisp8 RM: srcReg RO: destReg);
			at: 2 put: (self s: SIB1 i: 4 b: srcReg);
			at: 3 put: (offset bitAnd: 16rFF).
		 ^machineCodeSize := 4].
	machineCode
		at: 0 put: 16r8B;
		at: 1 put: (self mod: ModRegRegDisp32 RM: srcReg RO: destReg);
		at: 2 put: (self s: SIB1 i: 4 b: srcReg);
		at: 3 put: (offset bitAnd: 16rFF);
		at: 4 put: (offset >> 8 bitAnd: 16rFF);
		at: 5 put: (offset >> 16 bitAnd: 16rFF);
		at: 6 put: (offset >> 24 bitAnd: 16rFF).
	^machineCodeSize := 7