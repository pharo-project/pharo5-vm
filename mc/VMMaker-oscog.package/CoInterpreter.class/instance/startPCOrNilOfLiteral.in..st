cog jit support
startPCOrNilOfLiteral: lit in: aMethodObj
	"Answer the startPC of lit if it is a (clean) block in aMethodObj, oitherwise answer nil."
	<api>
	| outerContext |
	(objectMemory isIntegerObject: lit) ifTrue:
		[^nil].
	(objectMemory lastPointerOf: lit) <= ClosureCopiedValuesIndex ifTrue:
		[^nil].
	(objectMemory isArrayNonInt: lit) ifTrue:
		[^nil].
	outerContext := objectMemory fetchPointer: ClosureOuterContextIndex ofObject: lit.
	(objectMemory isContext: outerContext) ifFalse:
		[^nil].
	aMethodObj ~~ (objectMemory fetchPointer: MethodIndex ofObject: outerContext) ifTrue:
		[^nil].
	^self quickFetchInteger: ClosureStartPCIndex ofObject: lit