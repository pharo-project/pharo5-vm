bytecode generators
genExtPushIntegerBytecode
	"229		11100101	i i i i i i i i	Push Integer #iiiiiiii (+ Extend B * 256, where bbbbbbbb = sddddddd, e.g. -32768 = i=0, a=0, s=1)"
	| value |
	value := byte1 + (extB << 8).
	extB := 0.
	^self genPushLiteral: (objectMemory integerObjectOf: value)