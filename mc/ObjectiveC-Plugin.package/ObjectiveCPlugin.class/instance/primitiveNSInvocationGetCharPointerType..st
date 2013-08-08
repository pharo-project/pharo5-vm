system primitives
primitiveNSInvocationGetCharPointerType: bufferAddressOop
	|  buffer stringOop bufferPointer |
	self primitive: 'primitiveNSInvocationGetCharPointerType'
		parameters: #(Oop).
	self var: 'bufferPointer' declareC: 'char ** bufferPointer'.
	self var: 'buffer' declareC: 'char * buffer'.

	bufferPointer := self cCoerce: (interpreterProxy positive64BitValueOf: bufferAddressOop) to: 'char **'.
	interpreterProxy failed ifTrue: [^nil].
	self cCode: 'buffer = *bufferPointer'.
	stringOop := self stringFromCString: buffer.
	^stringOop
