gc - scavenging
rtRefCountOf: obj put: refCount
	"Set the rt reference count of obj; this is the three bit field comprised
	 of isGrey,isPinned,isRemembered.  See computeRefCountToShrinkRT."
	self subclassResponsibility