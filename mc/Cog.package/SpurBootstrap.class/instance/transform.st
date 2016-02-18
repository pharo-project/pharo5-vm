bootstrap image
transform
      self silenceImage.
	self findRequiredGlobals.
	self installModifiedMethods.
	self recreateSpecialObjectsArray.
	self initializeClasses.
	self bootstrapImage.
	self validate.
	self rehashImage.
	self followForwardingPointers.
	self scavengeImage.
	self freeForwarders.
	self compactImage.
	self reportSizes