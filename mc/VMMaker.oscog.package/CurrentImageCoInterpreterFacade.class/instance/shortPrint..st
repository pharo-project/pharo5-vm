accessing
shortPrint: oop
	^(objectMemory isImmediate: oop)
		ifTrue: [coInterpreter shortPrint: oop]
		ifFalse: [(objectMap keyAtValue: oop) printString]