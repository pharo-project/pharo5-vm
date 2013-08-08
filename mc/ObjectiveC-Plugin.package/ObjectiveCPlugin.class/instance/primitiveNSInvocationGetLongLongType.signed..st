system primitives
primitiveNSInvocationGetLongLongType: bufferAddressOop signed: signedBoolean
	|  buffer data unsignedData |
	self primitive: 'primitiveNSInvocationGetLongLongType'
		parameters: #(Oop Boolean).
	self var: 'buffer' declareC: 'long long * buffer'.
	self var: 'data' declareC: 'long long data'.
	self var: 'unsignedData' declareC: 'unsigned long long unsignedData'.

	buffer := self cCoerce: (interpreterProxy positive64BitValueOf: bufferAddressOop) to: 'long long *'.
	interpreterProxy failed ifTrue: [^nil].
	self touch: buffer.
	unsignedData := data := 0.
	signedBoolean 
			ifTrue: [self cCode: 'data = *buffer'.
					^interpreterProxy signed64BitIntegerFor: (self cCoerce: data to: 'long long') ]
			ifFalse: [self cCode: 'unsignedData = * (unsigned long long*) buffer'.
					^interpreterProxy positive64BitIntegerFor: (self cCoerce: unsignedData to: 'unsigned long long') ].
