cog jit support
methodNeedsLargeContext: methodObj
	<api>
	^self methodHeaderIndicatesLargeFrame: (objectMemory methodHeaderOf: methodObj)