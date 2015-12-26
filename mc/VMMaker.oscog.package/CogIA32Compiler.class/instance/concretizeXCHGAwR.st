generate machine code
concretizeXCHGAwR
	<inline: true>
	| addressOperand reg |
	addressOperand := operands at: 0.
	reg := operands at: 1.
	machineCode
		at: 0 put: 16r87;
		at: 1 put: (self mod: ModRegInd RM: 5 RO: reg);
		at: 2 put: (addressOperand bitAnd: 16rFF);
		at: 3 put: (addressOperand >> 8 bitAnd: 16rFF);
		at: 4 put: (addressOperand >> 16 bitAnd: 16rFF);
		at: 5 put: (addressOperand >> 24 bitAnd: 16rFF).
	^machineCodeSize := 6