control primitives
closureIn: context numArgs: numArgs instructionPointer: initialIP copiedValues: copiedValues
	| newClosure numCopied |
	<inline: true>
	"numCopied should be zero for nil"
	numCopied := objectMemory numSlotsOf: copiedValues.
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
	objectMemory
		storePointerUnchecked: ClosureOuterContextIndex ofObject: newClosure withValue: context;
		storePointerUnchecked: ClosureStartPCIndex ofObject: newClosure withValue: (objectMemory integerObjectOf: initialIP);
		storePointerUnchecked: ClosureNumArgsIndex ofObject: newClosure withValue: (objectMemory integerObjectOf: numArgs).
	0 to: numCopied - 1 do:
		[:i|
		objectMemory storePointerUnchecked: i + ClosureFirstCopiedValueIndex
			ofObject: newClosure
			withValue: (objectMemory fetchPointer: i ofObject: copiedValues)].
	^newClosure