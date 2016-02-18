stack bytecodes
extPushPseudoVariableOrOuterBytecode
	"77			01001101		Push false [* 1:true, 2:nil, 3:thisContext, ..., -N: pushExplicitOuter: N, N = Extend B]"
	| thing |
	self fetchNextBytecode.
	thing := extB
				caseOf: {
					[0]	->	[^self internalPush: objectMemory falseObject].
					[1]	->	[objectMemory trueObject].
					[2]	->	[objectMemory nilObject].
					[3]	->	[| context |
							 context := self ensureFrameIsMarried: localFP SP: localSP.
							 context]
				}
				otherwise:
					[extB < 0
						ifTrue:
							[self 
								enclosingObjectAt: 0 - extB 
								withObject: self receiver 
								withMixin: (self methodClassOf: method)]
						ifFalse:
							[self error: 'undefined extension for extPushPseudoVariableOrOuter'.
							 objectMemory nilObject]].
	extB := 0.
	self internalPush: thing