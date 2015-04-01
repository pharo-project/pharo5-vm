*VMMaker-InterpreterSimulation
simulateBalloonPrimitive: aString args: args
	^ Smalltalk at: #BalloonEngineSimulation ifPresent: [:be |
			be simulatePrimitive: aString receiver: self args: args]