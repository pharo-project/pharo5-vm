debug printing
printStringOf: oop

	super printStringOf: oop.
	traceOn ifTrue: [transcript flush]