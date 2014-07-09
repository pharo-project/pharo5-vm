bootstrap methods
findClassNamed: symbolOop 
	oldHeap allObjectsDo:
		[:o|
		((oldHeap isPointersNonImm: o)
		 and: [(oldInterpreter addressCouldBeClassObj: o)
		 and: [(oldHeap fetchPointer: oldInterpreter classNameIndex ofObject: o) = symbolOop]]) ifTrue:
			[^o]].
	^nil