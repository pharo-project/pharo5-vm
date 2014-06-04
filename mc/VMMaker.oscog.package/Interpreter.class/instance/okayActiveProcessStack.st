debug support
okayActiveProcessStack

	| cntxt |
	cntxt := activeContext.	
	[cntxt = nilObj] whileFalse: [
		self okayFields: cntxt.
		cntxt := (self fetchPointer: SenderIndex ofObject: cntxt).
	].