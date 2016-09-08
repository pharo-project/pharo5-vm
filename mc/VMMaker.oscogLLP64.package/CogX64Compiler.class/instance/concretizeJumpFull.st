generate machine code
concretizeJumpFull
	"Since JumpFull (and CallFull) is used to invoke code in dynamically-loaded plugins it shouldn't
	 assume that code will be loaded within 2Gb of the code zone.  Hence generate a full 64-bit call,
	 movabsq 0x123456789abcdef0, %rax; jmpq *%rax."
	<inline: true>
	| operand |
	operand := operands at: 0.
	machineCode
		at: 0 put: 16r48;
		at: 1 put: 16rB8;
		at: 2 put: (operand bitAnd: 16rFF);
		at: 3 put: (operand >> 8 bitAnd: 16rFF);
		at: 4 put: (operand >> 16 bitAnd: 16rFF);
		at: 5 put: (operand >> 24 bitAnd: 16rFF);
		at: 6 put: (operand >> 32 bitAnd: 16rFF);
		at: 7 put: (operand >> 40 bitAnd: 16rFF);
		at: 8 put: (operand >> 48 bitAnd: 16rFF);
		at: 9 put: (operand >> 56 bitAnd: 16rFF);
		at: 10 put: 16rFF;
		at: 11 put: (self mod: ModReg RM: RAX RO: 4).
	^machineCodeSize := 12