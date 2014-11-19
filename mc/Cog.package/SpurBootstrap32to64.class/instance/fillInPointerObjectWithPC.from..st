bootstrap image
fillInPointerObjectWithPC: obj64 from: obj32
	| method |
	self fillInPointerObject: obj64 from: obj32.
	(heap64 classIndexOf: obj64) = ClassBlockClosureCompactIndex ifTrue:
		[method := heap32
						fetchPointer: MethodIndex
						ofObject: (heap32
									fetchPointer: ClosureOuterContextIndex
									ofObject: obj32).
		self incrementPCField: ClosureStartPCIndex ofObject: obj64 for: method].
	(heap64 classIndexOf: obj64) = ClassMethodContextCompactIndex ifTrue:
		[method := heap32
						fetchPointer: MethodIndex
						ofObject: obj32.
		 self incrementPCField: InstructionPointerIndex ofObject: obj64 for: method]