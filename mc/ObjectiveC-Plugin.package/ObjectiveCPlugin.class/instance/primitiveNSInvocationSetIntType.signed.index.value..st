system primitives
primitiveNSInvocationSetIntType: aMethodSignatureOop signed: signedBoolean index: index value: intValue
	|  nsInvocationInstance buffer aValue |
	self primitive: 'primitiveNSInvocationSetIntType'
		parameters: #(Oop Boolean SmallInteger Oop).
	self var: 'nsInvocationInstance' declareC: 'NSInvocation* nsInvocationInstance'.
	self var: 'aValue' declareC: 'int aValue'.
	self var: 'buffer' declareC: 'void * buffer'.

	nsInvocationInstance := self cCoerce: (interpreterProxy positive64BitValueOf: aMethodSignatureOop) to: 'NSInvocation *'.
	interpreterProxy failed ifTrue: [^nil].
	signedBoolean 
			ifTrue: [aValue := self cCoerce: (interpreterProxy signed64BitValueOf: intValue) to: 'int'.
					interpreterProxy failed ifTrue: [^nil].
				self cCode: 'buffer = malloc(sizeof(int));
						*(int*) buffer = (int) aValue']
			ifFalse: [aValue := self cCoerce: (interpreterProxy positive64BitValueOf: intValue) to: 'unsigned int'.
					interpreterProxy failed ifTrue: [^nil].
				self cCode: 'buffer = malloc(sizeof(unsigned int));
					*(unsigned int*)buffer = (unsigned int) aValue'].
	self touch: nsInvocationInstance.
	self touch: buffer.
	self cCode: '    NS_DURING'. 
	self cCode:  '[nsInvocationInstance setArgument: buffer atIndex: index]'.
	self cCode: '    NS_HANDLER'.
		interpreterProxy success: false.
		true ifTrue: [^nil].
	self cCode: '    NS_ENDHANDLER'.
	^interpreterProxy positive64BitIntegerFor: (self cCoerce: buffer to: 'usqInt') 