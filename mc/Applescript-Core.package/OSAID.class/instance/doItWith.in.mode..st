interpretation
doItWith: anApplescriptInstance in: aContext mode: anInteger

	| resultID displayResult |
	resultID := anApplescriptInstance executeOSAID: self in: aContext mode: anInteger.
	resultID ifNil: [^nil].
	displayResult := anApplescriptInstance 
		displayAndDisposeOSAID: resultID 
		as: 'TEXT' 
		mode: anInteger.
	displayResult ifNil: [^nil].
	^displayResult asStringThenDispose