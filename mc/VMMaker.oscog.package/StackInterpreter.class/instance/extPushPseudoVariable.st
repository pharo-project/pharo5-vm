stack bytecodes
extPushPseudoVariable
	"SistaV1:	*	82			01010010			Push thisContext, (then e.g. Extend 1 = push thisProcess)"
	extA
		caseOf: {
			[0]	->	[self pushActiveContextBytecode].
			[1]	->	[self internalPush: self activeProcess] }
		otherwise:
			[self respondToUnknownBytecode].
	self fetchNextBytecode.
	extA := 0