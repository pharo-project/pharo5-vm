bootstrap image
transform
	self rememberRehashSymbol.
	self findRequiredGlobals.
	self installModifiedMethods.
	self bootstrapImage.
	self validate.
	self rehashImage.
	self followForwardingPointers.
	self scavengeImage.
	self freeForwarders.
	self compactImage.
	Transcript nextPutAll: 'done.'; flush.