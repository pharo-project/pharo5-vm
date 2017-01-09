bytecode generators
genExtPushPseudoVariableOrOuterBytecode
	"77			01001101		Push false [* 1:true, 2:nil, 3:thisContext, ..., -N: pushEnclosingObjectAt: N, N = Extend B]"
	| ext |
	ext := extB.
	extB := 0.
	numExtB := 0.
	ext caseOf: {
		[0]	->	[^self genPushLiteral: objectMemory falseObject].
		[1]	->	[^self genPushLiteral: objectMemory trueObject].
		[2]	->	[^self genPushLiteral: objectMemory nilObject].
		[3]	->	[^self genPushActiveContextBytecode]
		}
		otherwise:
			[ext < 0 ifTrue:
				[^self genPushEnclosingObjectAt: 0 - ext].
			 self warning: 'undefined extension for extPushPseudoVariableOrOuter'.
			 ^self unknownBytecode].
	^0