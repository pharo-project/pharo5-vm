processing
valueWith: anApplescriptInstance in: contextOSAID mode: anInteger

	^anApplescriptInstance 
		doCompiledScript: self 
		in: contextOSAID 
		mode: anInteger
