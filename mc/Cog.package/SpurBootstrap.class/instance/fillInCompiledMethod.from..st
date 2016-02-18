bootstrap image
fillInCompiledMethod: newObj from: oldObj
	| firstByteIndex primIndex |
	self fillInPointerObject: newObj from: oldObj.
	"Now convert the CompiledMethod's format.  First write the header in the new format"
	newHeap
		storePointerUnchecked: 0
		ofObject: newObj
		withValue: (newHeap integerObjectOf: (self convertOldMethodHeader: (oldHeap fetchPointer: 0 ofObject: oldObj))).
	"Then if necessary prepend the callPrimitive: bytecode"
	(primIndex := oldInterpreter primitiveIndexOf: oldObj) > 0
		ifTrue:
			[firstByteIndex := oldHeap lastPointerOf: oldObj.
			 newHeap
				storeByte: firstByteIndex + 0 ofObject: newObj withValue: 139;
				storeByte: firstByteIndex + 1 ofObject: newObj withValue: (primIndex bitAnd: 255);
				storeByte: firstByteIndex + 2 ofObject: newObj withValue: (primIndex bitShift: -8).
			 firstByteIndex to: (oldHeap numBytesOfBytes: oldObj) - 1 do:
				[:i|
				newHeap storeByte: i + 3 ofObject: newObj withValue: (oldHeap fetchByte: i ofObject: oldObj)]]
		ifFalse:
			[(oldHeap lastPointerOf: oldObj) / oldHeap wordSize to: (oldHeap numSlotsOf: oldObj) - 1 do:
				[:i|
				newHeap storeLong32: i ofObject: newObj withValue: (oldHeap fetchLong32: i ofObject: oldObj)]]