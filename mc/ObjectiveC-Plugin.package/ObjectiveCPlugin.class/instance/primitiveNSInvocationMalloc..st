system primitives
primitiveNSInvocationMalloc: size
	|  pointer |
	self primitive: 'primitiveNSInvocationMalloc'
		parameters: #(SmallInteger).
	self var: 'pointer' declareC: 'void* pointer'.
	self cCode: 'pointer = malloc(size)'.
	^interpreterProxy positive64BitIntegerFor: (self cCoerce: pointer to: 'usqInt') 