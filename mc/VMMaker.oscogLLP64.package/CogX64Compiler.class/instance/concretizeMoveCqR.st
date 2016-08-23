generate machine code
concretizeMoveCqR
	"Will get inlined into concretizeAt: switch.
	 On x64 we can short-cut mov 0, reg using xor, and use 32-bit displacement, signed or unsigned, if possible."
	<inline: true>
	| value reg |
	value := operands at: 0.
	(self is32BitSignedImmediate: value) ifFalse:
		[^self concretizeMoveCwR].
	reg := operands at: 1.
	value = 0 ifTrue:
		[machineCode
			at: 0 put: (self rexR: reg x: 0 b: reg);
			at: 1 put: 16r31;
			at: 2 put: (self mod: ModReg RM: reg RO: reg).
		^machineCodeSize := 3].
	machineCode
		at: 0 put: (self rexR: 0 x: 0 b: reg);
		at: 1 put: 16rC7;
		at: 2 put: (self mod: ModReg RM: reg RO: 0);
		at: 3 put: (value bitAnd: 16rFF);
		at: 4 put: (value >> 8 bitAnd: 16rFF);
		at: 5 put: (value >> 16 bitAnd: 16rFF);
		at: 6 put: (value >> 24 bitAnd: 16rFF).
	^machineCodeSize := 7