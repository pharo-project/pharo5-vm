simulation only
methodForContext: aContextOop
	self assert: (objectMemory isContext: aContextOop).
	^objectMemory fetchPointer: MethodIndex ofObject: aContextOop