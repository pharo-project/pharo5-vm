stack bytecodes
extPushIntegerBytecode
	"229		11100101	i i i i i i i i	Push Integer #iiiiiiii (+ Extend B * 256, where bbbbbbbb = sddddddd, e.g. -32768 = i=0, a=0, s=1)"
	| value |
	value := self fetchByte + (extB << 8).
	self fetchNextBytecode.
	extB := 0.
	self internalPush: (objectMemory integerObjectOf: value)