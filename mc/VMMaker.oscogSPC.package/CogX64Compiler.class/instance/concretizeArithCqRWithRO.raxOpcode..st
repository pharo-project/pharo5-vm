generate machine code
concretizeArithCqRWithRO: regOpcode raxOpcode: raxOpcode
	"Will get inlined into concretizeAt: switch."
	<inline: false>
	| value reg |
	value := operands at: 0.
	reg := operands at: 1.
	machineCode
		at: 0 put: (self rexR: 0 x: 0 b: reg).
	(self isQuick: value) ifTrue:
		[machineCode
			at: 1 put: 16r83;
			at: 2 put: (self mod: ModReg RM: reg RO: regOpcode);
			at: 3 put: (value bitAnd: 16rFF).
		 ^machineCodeSize := 4].
	(self is32BitSignedImmediate: value) ifTrue:
		[reg = RAX ifTrue:
			[machineCode
				at: 1 put: raxOpcode;
				at: 2 put: (value bitAnd: 16rFF);
				at: 3 put: (value >> 8 bitAnd: 16rFF);
				at: 4 put: (value >> 16 bitAnd: 16rFF);
				at: 5 put: (value >> 24 bitAnd: 16rFF).
			 ^machineCodeSize := 6].
		machineCode
			at: 1 put: 16r81;
			at: 2 put: (self mod: ModReg RM: reg RO: regOpcode);
			at: 3 put: (value bitAnd: 16rFF);
			at: 4 put: (value >> 8 bitAnd: 16rFF);
			at: 5 put: (value >> 16 bitAnd: 16rFF);
			at: 6 put: (value >> 24 bitAnd: 16rFF).
		 ^machineCodeSize := 7].
	^self concretizeArithCwR: (raxOpcode = 16r3D "Cmp" ifTrue: [16r39] ifFalse: [raxOpcode - 2])