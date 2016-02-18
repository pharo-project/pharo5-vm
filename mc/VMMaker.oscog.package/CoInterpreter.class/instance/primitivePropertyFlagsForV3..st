cog jit support
primitivePropertyFlagsForV3: primIndex
	<inline: true>
	"Answer any special requirements of the given primitive"
	| baseFlags |
	baseFlags := profileSemaphore ~= objectMemory nilObject
					ifTrue: [PrimCallNeedsNewMethod + PrimCallCollectsProfileSamples]
					ifFalse: [0].

	longRunningPrimitiveCheckSemaphore ifNotNil:
		[baseFlags := baseFlags bitOr: PrimCallNeedsNewMethod].

	self cCode: [] inSmalltalk: [#(primitiveExternalCall primitiveCalloutToFFI)]. "For senders..."
		(primIndex == 117 "#primitiveExternalCall"
	 or: [primIndex == 120 "#primitiveCalloutToFFI"]) ifTrue: "For callbacks"
		[baseFlags := baseFlags bitOr: PrimCallNeedsNewMethod + PrimCallNeedsPrimitiveFunction + PrimCallMayCallBack].

	^baseFlags