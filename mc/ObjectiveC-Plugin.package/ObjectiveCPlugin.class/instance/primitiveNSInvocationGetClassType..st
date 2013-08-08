system primitives
primitiveNSInvocationGetClassType: bufferAddressOop
	|  buffer data |
	self primitive: 'primitiveNSInvocationGetClassType'
		parameters: #(Oop).
	self var: 'buffer' declareC: 'Class * buffer'.
	self var: 'data' declareC: 'Class data'.

	buffer := self cCoerce: (interpreterProxy positive64BitValueOf: bufferAddressOop) to: 'Class *'.
	interpreterProxy failed ifTrue: [^nil].
	self touch: buffer.
	self cCode: 'data = *buffer'.
	^interpreterProxy positive64BitIntegerFor: (self cCoerce: data to: 'usqInt') 
