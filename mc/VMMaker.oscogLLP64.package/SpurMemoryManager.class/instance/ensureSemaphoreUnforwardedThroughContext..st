interpreter access
ensureSemaphoreUnforwardedThroughContext: aSemaphore
	"Make sure that the aSemaphore is followed through to the suspendedContext of the first link."
	<inline: true>
	| proc ctxt |
	proc := self fetchPointer: FirstLinkIndex ofObject: aSemaphore.
	(self isForwarded: proc) ifTrue:
		[self followForwardedObjectFields: aSemaphore toDepth: 1.
		 proc := self fetchPointer: FirstLinkIndex ofObject: aSemaphore].
	self deny: (self isForwarded: proc).
	ctxt := self fetchPointer: SuspendedContextIndex ofObject: proc.
	(self isForwarded: ctxt) ifTrue:
		[ctxt := self followForwarded: ctxt.
		 self storePointer: SuspendedContextIndex ofObject: proc withValue: ctxt]