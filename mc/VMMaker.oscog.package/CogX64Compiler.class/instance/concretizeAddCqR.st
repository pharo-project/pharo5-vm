generate machine code
concretizeAddCqR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| mask reg |
	mask := operands at: 0.
	reg := self concreteRegister: (operands at: 1).
	machineCode
		at: 0 put: (self rexR: 0 x: 0 b: reg).
	(self isQuick: mask) ifTrue:
		[machineCode
			at: 1 put: 16r83;
			at: 2 put: (self mod: ModReg RM: reg RO: 0);
			at: 3 put: (mask bitAnd: 16rFF).
		 ^machineCodeSize := 4].
	self assert: mask >> 32 = 0.
	reg = RAX ifTrue:
		[machineCode
			at: 1 put: 16r05;
			at: 2 put: (mask bitAnd: 16rFF);
			at: 3 put: (mask >> 8 bitAnd: 16rFF);
			at: 4 put: (mask >> 16 bitAnd: 16rFF);
			at: 5 put: (mask >> 24 bitAnd: 16rFF).
		 ^machineCodeSize := 6].
	machineCode
		at: 1 put: 16r81;
		at: 2 put: (self mod: ModReg RM: reg RO: 0);
		at: 3 put: (mask bitAnd: 16rFF);
		at: 4 put: (mask >> 8 bitAnd: 16rFF);
		at: 5 put: (mask >> 16 bitAnd: 16rFF);
		at: 6 put: (mask >> 24 bitAnd: 16rFF).
	 ^machineCodeSize := 7