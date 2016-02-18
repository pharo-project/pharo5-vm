spur primitive compilation
actualsForMethod: aTMethod
	"Normal primitives have no arguments, but translated primitives do.
	 Override to answer actuals for translated primitives."
	^(aTMethod args size - 1 to: 0 by: -1) collect:
		[:i|
		 TSendNode new
			setSelector: #stackValue:
			receiver: (TVariableNode new setName: 'interpreterProxy')
			arguments: {TConstantNode new setValue: i}]