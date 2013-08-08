intermediate operations
executeAndDisposeOSAID: sourceOSAID in: contextOSAID mode: anInteger

	| objectOSAID result |
	objectOSAID := OSAID new.
	result := self 
		primOSAExecute: sourceOSAID 
		in: contextOSAID
		mode: anInteger 
		to: objectOSAID.
	sourceOSAID disposeWith: self.
	result isZero ifFalse: 
		[^nil].
	^objectOSAID