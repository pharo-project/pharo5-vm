intermediate operations
makeContextOSAID: anOSAID
	
	| result contextOSAID contextAEDesc |
	contextOSAID := OSAID new.
	result := self 
		primOSAMakeContext: (AEDesc nullType)
		parent: anOSAID
		to: contextOSAID.
	result isZero ifFalse: [^nil].
	contextAEDesc := self storeAndDisposeOSAID: contextOSAID type: 'scpt' mode: 0.
	contextAEDesc ifNil: [^nil].
	^ contextAEDesc asCompiledApplescriptThenDispose