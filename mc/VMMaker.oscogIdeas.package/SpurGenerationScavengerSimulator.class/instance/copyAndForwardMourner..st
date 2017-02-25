scavenger
copyAndForwardMourner: survivor
	| relocatedOop |
	relocatedOop := super copyAndForwardMourner: survivor.
	cameFrom ifNotNil:
		[cameFrom at: relocatedOop put: survivor].
	^relocatedOop