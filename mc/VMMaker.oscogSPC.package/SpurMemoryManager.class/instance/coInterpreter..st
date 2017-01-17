simulation
coInterpreter: aCoInterpreter
	<doNotGenerate>
	coInterpreter := aCoInterpreter.
	scavenger ifNotNil:
		[scavenger coInterpreter: aCoInterpreter].
	compactor ifNotNil:
		[compactor coInterpreter: aCoInterpreter]