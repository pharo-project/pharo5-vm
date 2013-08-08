intermediate operations
executeAndDisplayOSAID: anOSAID in: contextOSAID mode: anInteger

	| resultOSAID resultAEDesc |
	resultOSAID := (self executeOSAID: anOSAID in: contextOSAID mode: anInteger)
		ifNil: [^nil].
	resultAEDesc := (self displayAndDisposeOSAID: resultOSAID as: 'ut16' mode: anInteger)
		ifNil: [^nil].
	^resultAEDesc asStringThenDispose
  