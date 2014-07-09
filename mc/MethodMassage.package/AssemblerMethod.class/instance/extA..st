assembling
extA: anInteger 
	self ensureInstructions addLast: (Message selector: #extA: argument: anInteger)