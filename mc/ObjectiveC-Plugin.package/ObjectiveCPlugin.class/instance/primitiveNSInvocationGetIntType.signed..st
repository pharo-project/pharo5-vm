system primitives
primitiveNSInvocationGetIntType: bufferAddressOop signed: signedBoolean
	|  buffer data unsignedData |
	self primitive: 'primitiveNSInvocationGetIntType'
		parameters: #(Oop Boolean).
	self var: 'buffer' declareC: 'int * buffer'.
	self var: 'data' declareC: 'int data'.
	self var: 'unsignedData' declareC: 'unsigned int unsignedData'.

	buffer := self cCoerce: (interpreterProxy positive64BitValueOf: bufferAddressOop) to: 'int *'.
	interpreterProxy failed ifTrue: [^nil].
	self touch: buffer.
	unsignedData := data := 0.
	signedBoolean 
			ifTrue: [self cCode: 'data = *buffer'.
					^interpreterProxy signed32BitIntegerFor: (self cCoerce: data to: 'sqInt') ]
			ifFalse: [self cCode: 'unsignedData = *(unsigned int *)buffer'.
					^interpreterProxy positive32BitIntegerFor: (self cCoerce: unsignedData to: 'usqInt') ].
