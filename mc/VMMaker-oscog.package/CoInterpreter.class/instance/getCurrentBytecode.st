interpreter shell
getCurrentBytecode
	"currentBytecode will be private to the main dispatch loop in the generated code.
	 This method allows the currentBytecode to be retrieved from global variables.
	 Override to answer -1 if we're not in an interpreter frame."

	^((stackPages couldBeFramePointer: framePointer)
	   and: [(self isMachineCodeFrame: framePointer) not])
		ifTrue: [objectMemory byteAt: instructionPointer]
		ifFalse: [-1]