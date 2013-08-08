intermediate operations
makeContextAndDisposeOSAID: anOSAID
	
	| result contextAEDesc |
	contextAEDesc := AEDesc new.
	result := self 
		primOSAMakeContext: (AEDesc nullType)
		parent: anOSAID
		to: contextAEDesc.
	result isZero ifFalse: [^nil].
	anOSAID disposeWith: self.
	^ contextAEDesc asCompiledApplescriptThenDispose