bootstrap image
fillInCompiledMethod: newObj from: oldObj
	"oldInterpreter printOop: oldObj"
	"newInterpreter printOop: newObj"
	0 to: (oldHeap numPointerSlotsOf: oldObj) - 1 do:
		[:i| | oldOop newOop |
		 oldOop := oldHeap fetchPointer: i ofObject: oldObj.
		 newOop := self map32BitOop: oldOop.
		 newHeap
			storePointerUnchecked: i
			ofObject: newObj
			withValue: newOop].
	(oldInterpreter startPCOfMethod: oldObj)
		to: (oldHeap numBytesOf: oldObj) - 1
		do: [:j|
			newHeap
				storeByte: j 
				ofObject: newObj
				withValue: (oldHeap fetchByte: j ofObject: oldObj)]