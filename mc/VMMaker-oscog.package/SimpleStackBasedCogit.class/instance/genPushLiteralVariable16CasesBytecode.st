bytecode generators
genPushLiteralVariable16CasesBytecode
	"16-31		0001 i i i i		Push Literal Variable #iiii"
	^self genPushLiteralVariable: (byte0 bitAnd: 15)