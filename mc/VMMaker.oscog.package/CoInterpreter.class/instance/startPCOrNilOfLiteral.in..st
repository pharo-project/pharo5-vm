cog jit support
startPCOrNilOfLiteral: lit in: aMethodObj
	"Answer the startPC of lit if it is a (clean) block in aMethodObj, otherwise answer nil."
	<api>
	| outerContext |
	((objectMemory isNonImmediate: lit)
	 and: [(objectMemory formatOf: lit) = objectMemory indexablePointersFormat
	 and: [(objectMemory numSlotsOf: lit) >= ClosureFirstCopiedValueIndex]]) ifFalse:
		[^nil].
	outerContext := objectMemory fetchPointer: ClosureOuterContextIndex ofObject: lit.
	(objectMemory isContext: outerContext) ifFalse:
		[^nil].
	aMethodObj ~~ (objectMemory fetchPointer: MethodIndex ofObject: outerContext) ifTrue:
		[^nil].
	^self quickFetchInteger: ClosureStartPCIndex ofObject: lit