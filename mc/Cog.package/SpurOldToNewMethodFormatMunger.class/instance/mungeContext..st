munging
mungeContext: obj
	| method |
	method := heap fetchPointer: MethodIndex ofObject: obj.
	(heap primitiveIndexOfMethodHeader: (heap methodHeaderOf: method)) > 0 ifTrue:
		[self incrementPCField: InstructionPointerIndex ofObject: obj by: 3]