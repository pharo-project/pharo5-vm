compile abstract instructions
maybeHaltIfDebugPC 
	<cmacro: '() 0'> "Simulation only; void in C"
	((debugBytecodePointers includes: bytecodePC)
	 and: [breakMethod isNil or: [methodObj = breakMethod]]) ifTrue:
		[self halt]