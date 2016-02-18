inline cacheing
nsSendCacheAt: callSiteReturnAddress
	"Answer the NSSendCache for the return address of a Newspeak
	 self, super, outer, or implicit receiver send."
	<inline: true>
	^objectMemory longAt: (self pcRelativeAddressAt: (callSiteReturnAddress - 8) asUnsignedInteger)