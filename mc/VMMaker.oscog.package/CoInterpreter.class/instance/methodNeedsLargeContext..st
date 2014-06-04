cog jit support
methodNeedsLargeContext: methodObj
	<api>
	^(self headerOf: methodObj) anyMask: LargeContextBit