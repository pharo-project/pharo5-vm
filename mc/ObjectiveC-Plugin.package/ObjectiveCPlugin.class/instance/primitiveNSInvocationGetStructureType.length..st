system primitives
primitiveNSInvocationGetStructureType: bufferAddressOop length: length
	|  bufferPointer newByteArray |
	self primitive: 'primitiveNSInvocationGetStructureType'
		parameters: #(Oop SmallInteger).
	self var: 'bufferPointer' declareC: 'char ** bufferPointer'.
	self var: 'buffer' declareC: 'char * buffer'.

	bufferPointer := self cCoerce: (interpreterProxy positive64BitValueOf: bufferAddressOop) to: 'void *'.
	interpreterProxy failed ifTrue: [^nil].
	newByteArray := interpreterProxy
		instantiateClass: interpreterProxy classByteArray
		indexableSize: length.
	self me: (interpreterProxy arrayValueOf: newByteArray)
		m: bufferPointer
		cpy: length. "void * memcpy(void *restrict s1, const void *restrict s2, size_t n)"
	^newByteArray
