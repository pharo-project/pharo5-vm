simulation only
printSimStack: aSimStack toDepth: limit spillBase: spillBase
	<doNotGenerate>
	coInterpreter transcript ensureCr.
	limit < 0 ifTrue:
		[^coInterpreter transcript nextPutAll: 'simStackEmpty'; cr; flush].
	0 to: limit do:
		[:i|
		coInterpreter transcript print: i.
		i = spillBase
			ifTrue: [coInterpreter transcript nextPutAll: ' sb'; tab]
			ifFalse: [coInterpreter transcript tab; tab].
		(aSimStack at: i) printStateOn: coInterpreter transcript.
		coInterpreter transcript cr; flush]