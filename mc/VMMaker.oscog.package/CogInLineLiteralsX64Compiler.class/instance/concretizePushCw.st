generate machine code
concretizePushCw
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| value |
	value := operands at: 0.
	machineCode
		at: 0 put: 16r68;
		at: 1 put: (value >> 8 bitAnd: 16rFF);
		at: 2 put: (value >> 16 bitAnd: 16rFF);
		at: 3 put: (value >> 24 bitAnd: 16rFF);
		at: 4 put: (value >> 32 bitAnd: 16rFF);
		at: 5 put: (value >> 40 bitAnd: 16rFF);
		at: 6 put: (value >> 48 bitAnd: 16rFF);
		at: 7 put: (value >> 56 bitAnd: 16rFF);
		at: 8 put: 16r90. "Add a nop to disambiguate between MoveCwR/PushCwR and ArithCwR, which ends with a (self mod: ModReg RM: 0 RO: 0)"
	self assert: (self mod: ModReg RM: 0 RO: 0) > 16r90.
	^machineCodeSize := 9