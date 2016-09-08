newspeak support
maybeAllocAndInitIRCs
	"If this is the Newspeak VM and the objectRepresentation supports pinning
	 then allocate space for the implicit receiver caches on the heap."
	NewspeakVM
		ifTrue:
			[indexOfIRC := theIRCs := 0.
			 (objectRepresentation canPinObjects and: [numIRCs > 0]) ifTrue:
				[self assert: (self noAssertMethodClassAssociationOf: methodObj) ~= objectMemory nilObject.
				 theIRCs := objectRepresentation allocateNPinnedSlots: numIRCs * NumOopsPerNSC.
				 ^theIRCs ~= 0].
			 ^true]
		ifFalse:
			[^true]