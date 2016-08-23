accessing
debugStackPointersFor: anOop
	^CArrayAccessor on:
		((StackDepthFinder on: (objectMap keyAtValue: anOop))
			encoderClass: (coInterpreter encoderClassForHeader: (objectMap keyAtValue: anOop) header);
			stackPointers)