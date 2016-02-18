bytecode generators
genPushLitVarDirSup16CasesBytecode
	"e.g. SistaV1: 16-31		0001 iiii			Push Literal Variable #iiii"
	^self genPushLiteralVariableGivenDirectedSuper: (byte0 bitAnd: 15)