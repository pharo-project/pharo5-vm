assembling
extB: anInteger 
	self ensureInstructions addLast: (Message selector: #extB: argument: anInteger)