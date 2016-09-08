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
		(primIndex = PrimNumberExternalCall "#primitiveExternalCall"
	 or: [primIndex = PrimNumberFFICall "#primitiveCalloutToFFI"]) ifTrue: "For callbacks"
		[baseFlags := baseFlags bitOr: PrimCallNeedsNewMethod + PrimCallNeedsPrimitiveFunction + PrimCallMayCallBack].

	^baseFlags