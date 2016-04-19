C translation support
maybeEmitPrimitiveFailureDefineFor: selector on: aStream
	 (vmClass notNil
	 and: [(vmClass inheritsFrom: InterpreterPrimitives)
	 and: [(vmClass primitiveTable includes: selector)]]) ifTrue:
		[aStream nextPutAll: '#else\# define ' withCRs; nextPutAll: selector; nextPutAll: ' (void (*)(void))0\' withCRs]