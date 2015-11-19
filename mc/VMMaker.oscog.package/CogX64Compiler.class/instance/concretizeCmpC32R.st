generate machine code
concretizeCmpC32R
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| value reg |
	value := operands at: 0.
	reg := self concreteRegister: (operands at: 1).
	reg = RAX ifTrue:
		[machineCode
			at: 0 put: 16r48;
			at: 1 put: 16r3D;
			at: 2 put: (value bitAnd: 16rFF);
			at: 3 put: (value >> 8 bitAnd: 16rFF);
			at: 4 put: (value >> 16 bitAnd: 16rFF);
			at: 5 put: (value >> 24 bitAnd: 16rFF).
		 ^machineCodeSize := 6].
	machineCode
		at: 0 put: 16r49;
		at: 1 put: 16r81;
		at: 2 put: (self mod: ModReg RM: reg RO: 7);
		at: 3 put: (value bitAnd: 16rFF);
		at: 4 put: (value >> 8 bitAnd: 16rFF);
		at: 5 put: (value >> 16 bitAnd: 16rFF);
		at: 6 put: (value >> 24 bitAnd: 16rFF).
	 ^machineCodeSize := 7