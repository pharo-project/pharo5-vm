munging
mungeClosure: obj
	| method |
	method := heap
					fetchPointer: MethodIndex
					ofObject: (heap
								fetchPointer: ClosureOuterContextIndex
								ofObject: obj).
	(heap primitiveIndexOfMethodHeader: (heap methodHeaderOf: method)) > 0 ifTrue:
		[self incrementPCField: ClosureStartPCIndex ofObject: obj by: 3]