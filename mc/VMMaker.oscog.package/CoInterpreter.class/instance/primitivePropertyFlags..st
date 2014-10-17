cog jit support
primitivePropertyFlags: primIndex
	<api>
	"Answer any special requirements of the given primitive"
	| baseFlags functionPointer |
	<var: #functionPointer declareC: 'void (*functionPointer)(void)'>
	functionPointer := self functionPointerFor: primIndex inClass: nil.

	"The complications of following forwarding pointers in machine code on failures
	 of primitives called indirectly through primitiveDoNamedPrimitiveWithArgs are not
	 worth dealing with, as primitiveDoNamedPrimitiveWithArgs is used only in debugging."
	(objectMemory hasSpurMemoryManagerAPI
	 and: [functionPointer = #primitiveDoNamedPrimitiveWithArgs]) ifTrue:
		[^PrimCallDoNotJIT].

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