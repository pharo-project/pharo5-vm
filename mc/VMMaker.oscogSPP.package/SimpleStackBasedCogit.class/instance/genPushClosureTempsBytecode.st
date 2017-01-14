bytecode generators
genPushClosureTempsBytecode
	"SistaV1: 230		11100110	iiiiiiii		PushNClosureTemps iiiiiiii"
	1 to: byte1 do:
		[:i| self genPushLiteral: objectMemory nilObject].
	^0