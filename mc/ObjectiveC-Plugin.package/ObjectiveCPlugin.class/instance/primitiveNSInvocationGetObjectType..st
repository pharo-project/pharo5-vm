system primitives
primitiveNSInvocationGetObjectType: bufferAddressOop
	|  buffer data |
	self primitive: 'primitiveNSInvocationGetObjectType'
		parameters: #(Oop).
	self var: 'buffer' declareC: 'id * buffer'.
	self var: 'data' declareC: 'id data'.

	buffer := self cCoerce: (interpreterProxy positive64BitValueOf: bufferAddressOop) to: 'id *'.
	interpreterProxy failed ifTrue: [^nil].
	self touch: buffer.
	self cCode: 'data = *buffer'.
	^interpreterProxy positive64BitIntegerFor: (self cCoerce: data to: 'usqInt') 
