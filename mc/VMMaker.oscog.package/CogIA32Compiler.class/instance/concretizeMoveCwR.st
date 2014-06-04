generate machine code
concretizeMoveCwR
	"Will get inlined into concretizeAt: switch.
	 Note that for quick constants, xor reg,reg, movq r8 may be shorter.
	 We don't consider it worthwhile for other  than 0."
	<inline: true>
	| value |
	value := operands at: 0.
	machineCode
		at: 0 put: 16rB8 + (self concreteRegister: (operands at: 1));
		at: 1 put: (value bitAnd: 16rFF);
		at: 2 put: (value >> 8 bitAnd: 16rFF);
		at: 3 put: (value >> 16 bitAnd: 16rFF);
		at: 4 put: (value >> 24 bitAnd: 16rFF).
	^machineCodeSize := 5