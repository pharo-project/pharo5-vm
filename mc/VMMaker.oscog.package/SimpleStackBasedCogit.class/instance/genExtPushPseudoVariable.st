bytecode generators
genExtPushPseudoVariable
	"SistaV1: *	82			01010010			Push thisContext, (then Extend B = 1 => push thisProcess)"
	| ext |
	ext := extB.
	extB := 0.
	numExtB := 0.
	ext caseOf: {
		[0]	->	[^self genPushActiveContextBytecode].
		}
		otherwise:
			[^self unknownBytecode].
	^0