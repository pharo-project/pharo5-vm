stack bytecodes
pushClosureTempsBytecode
	"SistaV1:	230		11100110	iiiiiiii		PushNClosureTemps iiiiiiii"
	| nTemps |
	nTemps := self fetchByte.
	self fetchNextBytecode.
	1 to: nTemps do:
		[:i|
		self internalPush: objectMemory nilObject]