cog jit support
primitivePropertyFlagsForSpur: primIndex
	<inline: true>
	"Answer any special requirements of the given primitive.  Spur always needs to set
	 primitiveFunctionPointer and newMethod so primitives can retry on failure due to forwarders."
	| baseFlags |
	baseFlags := PrimCallNeedsPrimitiveFunction + PrimCallNeedsNewMethod.
	profileSemaphore ~= objectMemory nilObject ifTrue:
		[baseFlags := baseFlags bitOr: PrimCallCollectsProfileSamples].

	self cCode: [] inSmalltalk: [#(primitiveExternalCall primitiveCalloutToFFI)]. "For senders..."
		(primIndex = PrimNumberExternalCall "#primitiveExternalCall"
	 or: [primIndex = PrimNumberFFICall "#primitiveCalloutToFFI"]) ifTrue: "For callbacks"
		[baseFlags := baseFlags bitOr: PrimCallMayCallBack.
		 checkAllocFiller ifTrue:
			[baseFlags := baseFlags bitOr: CheckAllocationFillerAfterPrimCall]].

	^baseFlags