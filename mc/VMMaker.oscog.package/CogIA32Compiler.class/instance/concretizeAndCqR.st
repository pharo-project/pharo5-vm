generate machine code
concretizeAndCqR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| mask reg |
	mask := operands at: 0.
	reg := operands at: 1.
	(self isQuick: mask) ifTrue:
		[machineCode
			at: 0 put: 16r83;
			at: 1 put: (self mod: ModReg RM: reg RO: 4);
			at: 2 put: (mask bitAnd: 16rFF).
		 ^machineCodeSize := 3].
	reg = EAX ifTrue:
		[machineCode
			at: 0 put: 16r25;
			at: 1 put: (mask bitAnd: 16rFF);
			at: 2 put: (mask >> 8 bitAnd: 16rFF);
			at: 3 put: (mask >> 16 bitAnd: 16rFF);
			at: 4 put: (mask >> 24 bitAnd: 16rFF).
		 ^machineCodeSize := 5].
	machineCode
		at: 0 put: 16r81;
		at: 1 put: (self mod: ModReg RM: reg RO: 4);
		at: 2 put: (mask bitAnd: 16rFF);
		at: 3 put: (mask >> 8 bitAnd: 16rFF);
		at: 4 put: (mask >> 16 bitAnd: 16rFF);
		at: 5 put: (mask >> 24 bitAnd: 16rFF).
	 ^machineCodeSize := 6