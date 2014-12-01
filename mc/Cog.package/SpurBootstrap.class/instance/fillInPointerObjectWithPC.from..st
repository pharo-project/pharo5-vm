bootstrap image
fillInPointerObjectWithPC: newObj from: oldObj
	"Fill-in a newObj with appropriately mapped contents from oldObj.
	 If the object has a pc and its method has a primitive, increment the
	 pc by the size of the callPrimitive: bytecode."
	| method |
	self fillInPointerObject: newObj from: oldObj.
	(newHeap classIndexOf: newObj) = classBlockClosureIndex ifTrue:
		[method := oldHeap
						fetchPointer: MethodIndex
						ofObject: (oldHeap
									fetchPointer: ClosureOuterContextIndex
									ofObject: oldObj).
		 (oldInterpreter primitiveIndexOf: method) > 0 ifTrue:
			[self incrementPCField: ClosureStartPCIndex ofObject: newObj by: 3]].
	(newHeap classIndexOf: newObj) = classMethodContextIndex ifTrue:
		[method := oldHeap
						fetchPointer: MethodIndex
						ofObject: oldObj.
		 (method ~= oldHeap nilObject
		  and: [(oldInterpreter primitiveIndexOf: method) > 0]) ifTrue:
			[self incrementPCField: InstructionPointerIndex ofObject: newObj by: 3]].