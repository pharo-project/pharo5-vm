bytecode generators
genExtPushCharacterBytecode
	"SistaV1:		233		11101001	iiiiiiii		Push Character #iiiiiiii (+ Extend B * 256)"
	| value |
	value := byte1 + (extB << 8).
	extB := 0.
	^self genPushLiteral: (objectMemory characterObjectOf: value)