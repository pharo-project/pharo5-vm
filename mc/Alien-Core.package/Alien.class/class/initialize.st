class initialization
initialize
	"
	Alien initialize
	"
	PlatformSizes := nil.
	GCMallocedAliens isNil ifTrue:
		[GCMallocedAliens := AlienWeakTable newForOwner: self].
	self ensureInSpecialObjectsArray.
	self ensureNotifiedAtStartup