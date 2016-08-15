scavenger
copyAndForward: survivor
	| relocatedOop |
	relocatedOop := super copyAndForward: survivor.
	cameFrom ifNotNil:
		[cameFrom at: relocatedOop put: survivor].
	^relocatedOop