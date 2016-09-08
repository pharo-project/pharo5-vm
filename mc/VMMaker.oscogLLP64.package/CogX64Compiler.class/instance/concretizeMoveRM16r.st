generate machine code
concretizeMoveRM16r
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| srcReg offset destReg skip |
	srcReg := operands at: 0.
	offset := operands at: 1.
	destReg := operands at: 2.
	machineCode at: 0 put: 16r66.
	(srcReg > 7 or: [destReg > 7])
		ifTrue:
			[machineCode at: 1 put: (self rexw: false r: srcReg x: 0 b: destReg).
			 skip := 1]
		ifFalse:
			[skip := 0].
	(destReg bitAnd: 7) ~= RSP ifTrue:
		[(self isQuick: offset) ifTrue:
			[machineCode
				at: skip + 1 put: 16r89;
				at: skip + 2 put: (self mod: ModRegRegDisp8 RM: destReg RO: srcReg);
				at: skip + 3 put: (offset bitAnd: 16rFF).
			 ^machineCodeSize := skip + 4].
		machineCode
			at: skip + 1 put: 16r89;
			at: skip + 2 put: (self mod: ModRegRegDisp32 RM: destReg RO: srcReg);
			at: skip + 3 put: (offset bitAnd: 16rFF);
			at: skip + 4 put: (offset >> 8 bitAnd: 16rFF);
			at: skip + 5 put: (offset >> 16 bitAnd: 16rFF);
			at: skip + 6 put: (offset >> 24 bitAnd: 16rFF).
		^machineCodeSize := skip + 7].
	"RSP:"
	(self isQuick: offset) ifTrue:
		[machineCode
			at: skip + 1 put: 16r89;
			at: skip + 2 put: (self mod: ModRegRegDisp8 RM: destReg RO: srcReg);
			at: skip + 3 put: (self s: SIB1 i: 4 b: destReg);
			at: skip + 4 put: (offset bitAnd: 16rFF).
		 ^machineCodeSize := skip + 5].
	machineCode
		at: skip + 1 put: 16r89;
		at: skip + 2 put: (self mod: ModRegRegDisp32 RM: destReg RO: srcReg);
		at: skip + 3 put: (self s: SIB1 i: 4 b: destReg);
		at: skip + 4 put: (offset bitAnd: 16rFF);
		at: skip + 5 put: (offset >> 8 bitAnd: 16rFF);
		at: skip + 6 put: (offset >> 16 bitAnd: 16rFF);
		at: skip + 7 put: (offset >> 24 bitAnd: 16rFF).
	^machineCodeSize := skip + 8