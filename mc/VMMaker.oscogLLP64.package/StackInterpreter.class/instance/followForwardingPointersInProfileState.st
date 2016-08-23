object memory support
followForwardingPointersInProfileState
	(objectMemory isForwarded: profileProcess) ifTrue:
		[profileProcess := objectMemory followForwarded: profileProcess].
	(objectMemory isForwarded: profileMethod) ifTrue:
		[profileMethod := objectMemory followForwarded: profileMethod].
	(objectMemory isForwarded: profileProcess) ifTrue:
		[profileSemaphore := objectMemory followForwarded: profileSemaphore].