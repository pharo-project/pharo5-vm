cog jit support
primitivePropertyFlagsForSpur: primIndex
	<inline: true>
	"Answer any special requirements of the given primitive.  Spur always needs to set
	 primitiveFunctionPointer and newMethod so primitives can retry on failure due to forwarders."
	| baseFlags |
	self cCode: [] inSmalltalk: [#(mcprimHashMultiply: primitiveExternalCall primitiveCalloutToFFI)]. "For senders..."
	primIndex = PrimNumberHashMultiply ifTrue:
		[^PrimCallOnSmalltalkStack].
	baseFlags := PrimCallNeedsPrimitiveFunction + PrimCallNeedsNewMethod.
	profileSemaphore ~= objectMemory nilObject ifTrue:
		[baseFlags := baseFlags bitOr: PrimCallCollectsProfileSamples].

		(primIndex = PrimNumberExternalCall "#primitiveExternalCall"
	 or: [primIndex = PrimNumberFFICall "#primitiveCalloutToFFI"]) ifTrue: "For callbacks"
		[baseFlags := baseFlags bitOr: PrimCallMayCallBack.
		 checkAllocFiller ifTrue:
			[baseFlags := baseFlags bitOr: CheckAllocationFillerAfterPrimCall]].

	^baseFlags