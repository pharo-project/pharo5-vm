generate machine code
concretizeCmpCqR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| value reg |
	value := operands at: 0.
	reg := self concreteRegister: (operands at: 1).
	machineCode
		at: 0 put: (self rexR: 0 x: 0 b: reg).
	(self isQuick: value) ifTrue:
		[machineCode
			at: 1 put: 16r83;
			at: 2 put: (self mod: ModReg RM: reg RO: 7);
			at: 3 put: (value bitAnd: 16rFF).
		 ^machineCodeSize := 4].
	self assert: value >> 32 = 0.
	reg = RAX ifTrue:
		[machineCode
			at: 1 put: 16r3D;
			at: 2 put: (value bitAnd: 16rFF);
			at: 3 put: (value >> 8 bitAnd: 16rFF);
			at: 4 put: (value >> 16 bitAnd: 16rFF);
			at: 5 put: (value >> 24 bitAnd: 16rFF).
		 ^machineCodeSize := 6].
	machineCode
		at: 1 put: 16r81;
		at: 2 put: (self mod: ModReg RM: reg RO: 7);
		at: 3 put: (value bitAnd: 16rFF);
		at: 4 put: (value >> 8 bitAnd: 16rFF);
		at: 5 put: (value >> 16 bitAnd: 16rFF);
		at: 6 put: (value >> 24 bitAnd: 16rFF).
	 ^machineCodeSize := 7