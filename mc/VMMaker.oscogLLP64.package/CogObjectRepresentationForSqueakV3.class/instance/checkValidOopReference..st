garbage collection
checkValidOopReference: anOop
	^(objectMemory isIntegerObject: anOop)
	   or: [(objectMemory heapMapAtWord: (self pointerForOop: anOop)) ~= 0]