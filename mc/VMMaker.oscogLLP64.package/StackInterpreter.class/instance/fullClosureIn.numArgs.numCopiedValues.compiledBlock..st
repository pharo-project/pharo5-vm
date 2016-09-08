control primitives
fullClosureIn: context numArgs: numArgs numCopiedValues: numCopied compiledBlock: compiledBlock 
	| newClosure |
	<inline: true>
	ClassFullBlockClosureCompactIndex ~= 0
		ifTrue:
			[newClosure := objectMemory
								eeInstantiateSmallClassIndex: ClassFullBlockClosureCompactIndex
								format: objectMemory indexablePointersFormat
								numSlots: FullClosureFirstCopiedValueIndex + numCopied]
		ifFalse:
			[newClosure := objectMemory
								eeInstantiateSmallClass: (objectMemory splObj: ClassFullBlockClosure)
								numSlots: FullClosureFirstCopiedValueIndex + numCopied].
	"Assume: have just allocated a new closure; it must be young. Thus, can use unchecked stores."
	objectMemory
		storePointerUnchecked: ClosureOuterContextIndex ofObject: newClosure withValue: context;
		storePointerUnchecked: FullClosureCompiledBlockIndex ofObject: newClosure withValue: compiledBlock;
		storePointerUnchecked: ClosureNumArgsIndex ofObject: newClosure withValue: (objectMemory integerObjectOf: numArgs).
	^newClosure