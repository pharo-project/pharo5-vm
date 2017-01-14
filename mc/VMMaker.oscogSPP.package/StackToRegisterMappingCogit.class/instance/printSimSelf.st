simulation only
printSimSelf
	<doNotGenerate>
	coInterpreter transcript ensureCr; nextPutAll: 'self: '.
	simSelf printStateOn: coInterpreter transcript.
	coInterpreter transcript cr; flush