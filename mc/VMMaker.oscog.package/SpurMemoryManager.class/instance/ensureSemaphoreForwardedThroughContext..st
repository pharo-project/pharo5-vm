interpreter access
ensureSemaphoreForwardedThroughContext: aSemaphore
	"Make sure that the aSemaphore is forwarded through to the suspendedContext of the first link."
	<inline: true>
	(self isForwarded: (self fetchPointer: FirstLinkIndex ofObject: aSemaphore)) ifTrue:
		["0 = aSemaphore, 1 = aProcess. Hence references to suspendedContext will /not/ be forwarded."
		 self followForwardedObjectFields: aSemaphore toDepth: 1].
	self deny: (self isForwarded: (self
									fetchPointer: SuspendedContextIndex
									ofObject: (self fetchPointer: FirstLinkIndex ofObject: aSemaphore)))