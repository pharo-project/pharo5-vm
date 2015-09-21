generate machine code
concretizeMoveCwR
	"Will get inlined into concretizeAt: switch.
	 Note that for quick constants, xor reg,reg, movq r8 may be shorter.
	 We don't consider it worthwhile for other  than 0."
	<inline: true>
	| value reg |
	value := operands at: 0.
	reg := self concreteRegister: (operands at: 1).
	machineCode
		at: 0 put: (self rexR: reg x: 0 b: reg);
		at: 1 put: 16rB8 + (reg bitAnd: 7);
		at: 2 put: (value bitAnd: 16rFF);
		at: 3 put: (value >> 8 bitAnd: 16rFF);
		at: 4 put: (value >> 16 bitAnd: 16rFF);
		at: 5 put: (value >> 24 bitAnd: 16rFF);
		at: 6 put: (value >> 32 bitAnd: 16rFF);
		at: 7 put: (value >> 40 bitAnd: 16rFF);
		at: 8 put: (value >> 48 bitAnd: 16rFF);
		at: 9 put: (value >> 56 bitAnd: 16rFF).
	^machineCodeSize := 10