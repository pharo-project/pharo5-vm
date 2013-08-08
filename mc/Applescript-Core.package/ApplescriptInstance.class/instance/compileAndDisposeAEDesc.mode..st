intermediate operations
compileAndDisposeAEDesc: sourceAEDesc mode: anInteger

	| objectOSAID result |
	objectOSAID := OSAID new.
	result := self	
		primOSACompile: sourceAEDesc
		mode: anInteger
		to: objectOSAID.
	sourceAEDesc dispose.
	result isZero ifFalse: [^nil].
	^objectOSAID
