bytecode generators
genSistaExtStoreLiteralVariableBytecodePopBoolean: boolean
	| index |
	extB := 0. "SimpleCogit don't use the extra flags"
	index := byte1 + (extA << 8).
	extA := 0.
	^ self genStorePop: boolean LiteralVariable: index