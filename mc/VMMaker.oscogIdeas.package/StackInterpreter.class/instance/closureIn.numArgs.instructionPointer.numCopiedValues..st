control primitives
closureIn: context numArgs: numArgs instructionPointer: initialIP numCopiedValues: numCopied
	| newClosure |
	<inline: true>
	ClassBlockClosureCompactIndex ~= 0
		ifTrue:
			[newClosure := objectMemory
								eeInstantiateSmallClassIndex: ClassBlockClosureCompactIndex
								format: objectMemory indexablePointersFormat
								numSlots: ClosureFirstCopiedValueIndex + numCopied]
		ifFalse:
			[newClosure := objectMemory
								eeInstantiateSmallClass: (objectMemory splObj: ClassBlockClosure)
								numSlots: ClosureFirstCopiedValueIndex + numCopied].
	"Assume: have just allocated a new closure; it must be young. Thus, can use unchecked stores."
	objectMemory storePointerUnchecked: ClosureOuterContextIndex ofObject: newClosure withValue: context.
	objectMemory storePointerUnchecked: ClosureStartPCIndex ofObject: newClosure withValue: (objectMemory integerObjectOf: initialIP).
	objectMemory storePointerUnchecked: ClosureNumArgsIndex ofObject: newClosure withValue: (objectMemory integerObjectOf: numArgs).
	^newClosure