generate machine code
concretizeTstCqR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| value reg |
	value := operands at: 0.
	reg := operands at: 1.
	machineCode
		at: 0 put: (self rexR: 0 x: 0 b: reg).
	(self isQuick: value) ifTrue:
		[machineCode
			at: 1 put: 16rF6;
			at: 2 put: (self mod: ModReg RM: reg RO: 0);
			at: 3 put: (value bitAnd: 16rFF).
		 ^machineCodeSize := 4].
	
	(self is32BitSignedImmediate: value) ifTrue:
		[reg = RAX ifTrue:
			[machineCode
				at: 1 put: 16rA9;
				at: 2 put: (value bitAnd: 16rFF);
				at: 3 put: (value >> 8 bitAnd: 16rFF);
				at: 4 put: (value >> 16 bitAnd: 16rFF);
				at: 5 put: (value >> 24 bitAnd: 16rFF).
			 ^machineCodeSize := 6].
		machineCode
			at: 1 put: 16rF7;
			at: 2 put: (self mod: ModReg RM: reg RO: 0);
			at: 3 put: (value bitAnd: 16rFF);
			at: 4 put: (value >> 8 bitAnd: 16rFF);
			at: 5 put: (value >> 16 bitAnd: 16rFF);
			at: 6 put: (value >> 24 bitAnd: 16rFF).
		 ^machineCodeSize := 7].
	^self concretizeArithCwR: 16r85