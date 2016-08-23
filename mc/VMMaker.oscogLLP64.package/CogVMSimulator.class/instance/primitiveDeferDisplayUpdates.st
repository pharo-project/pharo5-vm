I/O primitives
primitiveDeferDisplayUpdates
	| oldDeferDisplayUpdates |
	oldDeferDisplayUpdates := deferDisplayUpdates.
	super primitiveDeferDisplayUpdates.
	oldDeferDisplayUpdates ~= deferDisplayUpdates ifTrue:
		[self fullDisplayUpdate]