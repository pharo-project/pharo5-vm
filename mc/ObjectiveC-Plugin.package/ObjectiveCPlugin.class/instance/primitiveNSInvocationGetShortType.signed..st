system primitives
primitiveNSInvocationGetShortType: bufferAddressOop signed: signedBoolean
	|  buffer data unsignedData |
	self primitive: 'primitiveNSInvocationGetShortType'
		parameters: #(Oop Boolean).
	self var: 'buffer' declareC: 'short * buffer'.
	self var: 'data' declareC: 'short data'.
	self var: 'unsignedData' declareC: 'unsigned short unsignedData'.

	buffer := self cCoerce: (interpreterProxy positive64BitValueOf: bufferAddressOop) to: 'short *'.
	unsignedData := data := 0.
	interpreterProxy failed ifTrue: [^nil].
	self touch: buffer.
	signedBoolean 
			ifTrue: [self cCode: 'data = *buffer'.
					^interpreterProxy signed32BitIntegerFor: (self cCoerce: data to: 'sqInt') ]
			ifFalse: [self cCode: 'unsignedData = *(unsigned short *)buffer'.
					^interpreterProxy positive32BitIntegerFor: (self cCoerce: unsignedData to: 'usqInt') ].
