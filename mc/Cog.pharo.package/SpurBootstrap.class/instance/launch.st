testing
launch
	self launch: newHeap
		simulatorClass: StackInterpreterSimulator
		headerFlags: oldInterpreter getImageHeaderFlags