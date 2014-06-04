interpreter shell
getCurrentBytecode
	"currentBytecode will be private to the main dispatch loop in the generated code. This method allows the currentBytecode to be retrieved from global variables."

	^ self byteAt: instructionPointer