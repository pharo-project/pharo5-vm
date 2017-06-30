execution
interpreter: sim object: receiver perform: selector withArguments: arguments
	simulator := sim.
	^super interpreter: sim object: receiver perform: selector withArguments: arguments