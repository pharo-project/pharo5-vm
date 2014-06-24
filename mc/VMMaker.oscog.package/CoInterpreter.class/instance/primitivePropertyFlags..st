cog jit support
primitivePropertyFlags: primIndex
	<api>
	"Answer any special requirements of the given primitive"
	| baseFlags functionPointer |
	<var: #functionPointer declareC: 'void (*functionPointer)(void)'>
	functionPointer := self functionPointerFor: primIndex inClass: nil.

	baseFlags := profileSemaphore ~= objectMemory nilObject
					ifTrue: [PrimCallNeedsNewMethod + PrimCallCollectsProfileSamples]
					ifFalse: [0].

	longRunningPrimitiveCheckSemaphore ~= nil ifTrue:
		[baseFlags := baseFlags bitOr: PrimCallNeedsNewMethod].

		(functionPointer == #primitiveExternalCall
	 or: [functionPointer == #primitiveCalloutToFFI]) ifTrue: "For callbacks"
		[baseFlags := baseFlags bitOr: PrimCallNeedsNewMethod + PrimCallNeedsPrimitiveFunction + PrimCallMayCallBack.
		 checkAllocFiller ifTrue:
			[baseFlags := baseFlags bitOr: CheckAllocationFillerAfterPrimCall]].

	^baseFlags