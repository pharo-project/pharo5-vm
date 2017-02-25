accessing
startPCOfMethod: anOop
	^(objectMap keyAtValue: anOop) initialPC - 1