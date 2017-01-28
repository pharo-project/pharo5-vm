debug support
checkValidDerivedObjectReference: bodyAddress
	^(objectMemory heapMapAtWord: (self pointerForOop: bodyAddress - objectMemory baseHeaderSize)) ~= 0