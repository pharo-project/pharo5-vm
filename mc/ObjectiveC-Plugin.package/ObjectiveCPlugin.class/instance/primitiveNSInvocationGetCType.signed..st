system primitives
primitiveNSInvocationGetCType: bufferAddressOop signed: signedBoolean
	|  buffer newCharacterOop targetOopData |
	self primitive: 'primitiveNSInvocationGetCType'
		parameters: #(Oop Boolean).
	self var: 'buffer' declareC: 'char * buffer'.
	self var: 'targetOopData' declareC: 'char targetOopData'.

	buffer := self cCoerce: (interpreterProxy positive64BitValueOf: bufferAddressOop) to: 'char *'.
	interpreterProxy failed ifTrue: [^nil].
	self touch: buffer.
	newCharacterOop := interpreterProxy
		instantiateClass: interpreterProxy classCharacter
		indexableSize: 1.
	targetOopData := 0.
	self touch: targetOopData.
	signedBoolean 
			ifTrue: [self cCode: 'targetOopData = *(char*) buffer'. 
					interpreterProxy storeInteger: 0 ofObject: newCharacterOop withValue: 
					 (self cCoerce: targetOopData to: 'sqInt').]
			ifFalse: [self cCode: 'targetOopData = *(char*) buffer'.
					interpreterProxy storeInteger: 0 ofObject: newCharacterOop withValue: 
					 (self cCoerce: targetOopData to: 'usqInt').].
	
	^newCharacterOop