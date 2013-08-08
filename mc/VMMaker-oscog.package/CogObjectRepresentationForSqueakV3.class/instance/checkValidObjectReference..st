garbage collection
checkValidObjectReference: anOop
	^(objectMemory isIntegerObject: anOop)
	   or: [(self heapMapAtWord: (self pointerForOop: anOop)) ~= 0]