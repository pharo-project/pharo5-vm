inline cacheing
implicitReceiveCacheAt: callSiteReturnAddress
	"Answer the implicit receiver cache for the return address
	 of a call to one of the ceImplicitReceiver... trampolines."
	<inline: true>
	^objectMemory longAt: (self pcRelativeAddressAt: callSiteReturnAddress - 8)