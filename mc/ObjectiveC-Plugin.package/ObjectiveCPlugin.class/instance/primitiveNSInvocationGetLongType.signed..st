system primitives
primitiveNSInvocationGetLongType: bufferAddressOop signed: signedBoolean
	|  buffer data unsignedData |
	self primitive: 'primitiveNSInvocationGetLongType'
		parameters: #(Oop Boolean).
	self var: 'buffer' declareC: 'long * buffer'.
	self var: 'data' declareC: 'long data'.
	self var: 'unsignedData' declareC: 'unsigned long unsignedData'.

	buffer := self cCoerce: (interpreterProxy positive64BitValueOf: bufferAddressOop) to: 'long *'.
	interpreterProxy failed ifTrue: [^nil].
	self touch: buffer.
	unsignedData := data := 0.
	signedBoolean 
			ifTrue: [self cCode: 'data = *buffer'.
					^interpreterProxy signed64BitIntegerFor: (self cCoerce: data to: 'sqInt') ]
			ifFalse: [self cCode: 'unsignedData = *(unsigned long *) buffer'.
					^interpreterProxy positive64BitIntegerFor: (self cCoerce: unsignedData to: 'usqInt') ].
