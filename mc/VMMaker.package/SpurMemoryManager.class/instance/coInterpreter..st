simulation
coInterpreter: aCoInterpreter
	<doNotGenerate>
	coInterpreter := aCoInterpreter.
	scavenger ifNotNil:
		[scavenger coInterpreter: aCoInterpreter]