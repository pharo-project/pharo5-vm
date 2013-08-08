intermediate operations
executeOSAID: sourceOSAID in: contextOSAID mode: anInteger

	| objectOSAID result |
	objectOSAID := OSAID new.
	result := self 
		primOSAExecute: sourceOSAID 
		in: contextOSAID
		mode: anInteger 
		to: objectOSAID.
	result isZero ifFalse: [^nil].
	^objectOSAID