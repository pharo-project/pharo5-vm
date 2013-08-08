system primitives
primitiveNSInvocationGetDoubleType: bufferAddressOop
	|  buffer data |
	self primitive: 'primitiveNSInvocationGetDoubleType'
		parameters: #(Oop).
	self var: 'buffer' declareC: 'double * buffer'.
	self var: 'data' declareC: 'double data'.

	buffer := self cCoerce: (interpreterProxy positive64BitValueOf: bufferAddressOop) to: 'double *'.
	interpreterProxy failed ifTrue: [^nil].
	self touch: buffer.
	self cCode: 'data = *buffer'.
	^interpreterProxy floatObjectOf: data