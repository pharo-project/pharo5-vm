simulation only
printSimStack: aSimStack
	<doNotGenerate>
	self printSimStack: aSimStack toDepth: simStackPtr spillBase: simSpillBase on: coInterpreter transcript