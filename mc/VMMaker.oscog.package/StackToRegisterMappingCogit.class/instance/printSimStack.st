simulation only
printSimStack
	<doNotGenerate>
	coInterpreter transcript ensureCr.
	simStackPtr < 0 ifTrue:
		[^coInterpreter transcript nextPutAll: 'simStackEmpty'; cr; flush].
	0 to: simStackPtr do:
		[:i|
		coInterpreter transcript print: i.
		i = simSpillBase
			ifTrue: [coInterpreter transcript nextPutAll: ' sb'; tab]
			ifFalse: [coInterpreter transcript tab; tab].
		(simStack at: i) printStateOn: coInterpreter transcript.
		coInterpreter transcript cr; flush]