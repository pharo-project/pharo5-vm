system primitives
primitiveNSInvocationGetSelectorType: bufferAddressOop
	|  buffer data |
	self primitive: 'primitiveNSInvocationGetSelectorType'
		parameters: #(Oop).
	self var: 'buffer' declareC: 'SEL * buffer'.
	self var: 'data' declareC: 'SEL data'.

	buffer := self cCoerce: (interpreterProxy positive64BitValueOf: bufferAddressOop) to: 'SEL *'.
	interpreterProxy failed ifTrue: [^nil].
	self touch: buffer.
	self cCode: 'data = *buffer'.
	^interpreterProxy positive64BitIntegerFor: (self cCoerce: data to: 'usqInt') 
