stack bytecodes
extPushCharacterBytecode
	"SistaV1:	*	233		11101001	iiiiiiii		Push Character #iiiiiiii (+ Extend B * 256)"
	| value |
	value := self fetchByte + (extB << 8).
	self fetchNextBytecode.
	self internalPush: (objectMemory characterObjectOf: value).
	numExtB := extB := 0