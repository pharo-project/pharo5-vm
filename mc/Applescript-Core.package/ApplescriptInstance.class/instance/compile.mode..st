interpreting
compile: aString mode: anInteger

	| sourceAEDesc objectOSAID objectAEDesc |
	sourceAEDesc := AEDesc textTypeOn: aString.
	(objectOSAID := self 
		compileAndDisposeAEDesc: sourceAEDesc 
		mode: anInteger) ifNil: [^nil].
	(objectAEDesc := self 
		storeAndDisposeOSAID: objectOSAID 
		type: 'scpt' 
		mode: anInteger) ifNil: [^nil].
	^objectAEDesc asCompiledApplescriptThenDispose
