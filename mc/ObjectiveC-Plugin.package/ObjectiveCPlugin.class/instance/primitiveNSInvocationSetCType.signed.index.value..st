system primitives
primitiveNSInvocationSetCType: aMethodSignatureOop signed: signedBoolean index: index value: newCharacterOop
	|  nsInvocationInstance buffer aValue aUnsignedValue |
	self primitive: 'primitiveNSInvocationSetCType'
		parameters: #(Oop Boolean SmallInteger Oop).
	self var: 'nsInvocationInstance' declareC: 'NSInvocation* nsInvocationInstance'.
	self var: 'buffer' declareC: 'void * buffer'.
	self var: 'aValue' declareC: 'char aValue'.
	self var: 'aUnsignedValue' declareC: 'unsigned char aUnsignedValue'.

	nsInvocationInstance := self cCoerce: (interpreterProxy positive64BitValueOf: aMethodSignatureOop) to: 'NSInvocation *'.
	interpreterProxy failed ifTrue: [^nil].
	aValue := interpreterProxy fetchInteger: 0 ofObject: newCharacterOop.
	aUnsignedValue := interpreterProxy fetchInteger: 0 ofObject: newCharacterOop.
	signedBoolean 
			ifTrue: [self cCode: 'buffer = malloc(sizeof(char));
					*(char*) buffer = (char) aValue']
			ifFalse: [self cCode: 'buffer = malloc(sizeof(unsigned char));
					*(unsigned char*)buffer = (unsigned char) aUnsignedValue'].
	self touch: nsInvocationInstance.
	self touch: buffer.
	self cCode: '    NS_DURING'. 
	self cCode:  '[nsInvocationInstance setArgument: buffer atIndex: index]'.
	self cCode: '    NS_HANDLER'.
		interpreterProxy success: false.
		true ifTrue: [^nil].
	self cCode: '    NS_ENDHANDLER'.
	^interpreterProxy positive64BitIntegerFor: (self cCoerce: buffer to: 'usqInt') 