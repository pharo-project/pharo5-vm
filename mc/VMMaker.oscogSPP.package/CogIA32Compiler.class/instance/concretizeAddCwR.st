generate machine code
concretizeAddCwR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| value reg |
	value := operands at: 0.
	reg := operands at: 1.
	reg = EAX ifTrue:
		[machineCode
			at: 0 put: 16r05;
			at: 1 put: (value bitAnd: 16rFF);
			at: 2 put: (value >> 8 bitAnd: 16rFF);
			at: 3 put: (value >> 16 bitAnd: 16rFF);
			at: 4 put: (value >> 24 bitAnd: 16rFF).
		 ^machineCodeSize := 5].
	machineCode
		at: 0 put: 16r81;
		at: 1 put: (self mod: ModReg RM: reg RO: 0);
		at: 2 put: (value bitAnd: 16rFF);
		at: 3 put: (value >> 8 bitAnd: 16rFF);
		at: 4 put: (value >> 16 bitAnd: 16rFF);
		at: 5 put: (value >> 24 bitAnd: 16rFF).
	 ^machineCodeSize := 6