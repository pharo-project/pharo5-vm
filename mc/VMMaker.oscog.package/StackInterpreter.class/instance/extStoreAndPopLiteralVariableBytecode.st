stack bytecodes
extStoreAndPopLiteralVariableBytecode
	"236		11101100	i i i i i i i i	Pop and Store Literal Variable #iiiiiiii (+ Extend A * 256)"
	self extStoreLiteralVariableBytecode.
	self internalPop: 1