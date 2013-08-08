system primitives
primitiveNSInvocationGetFloatType: bufferAddressOop
	|  buffer data |
	self primitive: 'primitiveNSInvocationGetFloatType'
		parameters: #(Oop).
	self var: 'buffer' declareC: 'float * buffer'.
	self var: 'data' declareC: 'float data'.

	buffer := self cCoerce: (interpreterProxy positive64BitValueOf: bufferAddressOop) to: 'float *'.
	interpreterProxy failed ifTrue: [^nil].
	self touch: buffer.
	self cCode: 'data = *buffer'.
	^interpreterProxy floatObjectOf: data