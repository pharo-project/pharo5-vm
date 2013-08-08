system primitives
primitiveNSInvocationCalloc: size
	|  pointer |
	self primitive: 'primitiveNSInvocationCalloc'
		parameters: #(SmallInteger).
	self var: 'pointer' declareC: 'void* pointer'.
	self cCode: 'pointer = calloc(size,1)'.
	^interpreterProxy positive64BitIntegerFor: (self cCoerce: pointer to: 'usqInt') 