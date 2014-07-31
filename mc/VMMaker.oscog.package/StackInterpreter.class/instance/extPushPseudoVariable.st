stack bytecodes
extPushPseudoVariable
	"SistaV1:	*	82			01010010			Push thisContext, (then e.g. Extend B 1 = push thisProcess)"
	extB
		caseOf: {
			[0]	->	[self pushActiveContextBytecode].
			[1]	->	[self internalPush: self activeProcess] }
		otherwise:
			[self respondToUnknownBytecode].
	self fetchNextBytecode.
	extB := 0