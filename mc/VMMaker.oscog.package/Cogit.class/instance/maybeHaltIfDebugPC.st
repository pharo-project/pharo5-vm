compile abstract instructions
maybeHaltIfDebugPC 
	<cmacro: '() 0'> "Simulation only; void in C"
	(debugBytecodePointers includes: bytecodePC) ifTrue:
		[self halt]