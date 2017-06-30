execution
withExecutableInterpreter: sim do: aBlock
	simulator := sim.
	^super withExecutableInterpreter: sim do: aBlock