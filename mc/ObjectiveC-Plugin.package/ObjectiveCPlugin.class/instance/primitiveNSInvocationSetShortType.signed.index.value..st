system primitives
primitiveNSInvocationSetShortType: aMethodSignatureOop signed: signedBoolean index: index value: intValue
	|  nsInvocationInstance buffer aValue |
	self primitive: 'primitiveNSInvocationSetShortType'
		parameters: #(Oop Boolean SmallInteger Oop).
	self var: 'nsInvocationInstance' declareC: 'NSInvocation* nsInvocationInstance'.
	self var: 'aValue' declareC: 'short aValue'.
	self var: 'buffer' declareC: 'void * buffer'.

	nsInvocationInstance := self cCoerce: (interpreterProxy positive64BitValueOf: aMethodSignatureOop) to: 'NSInvocation *'.
	interpreterProxy failed ifTrue: [^nil].
	signedBoolean 
			ifTrue: [aValue := self cCoerce: (interpreterProxy signed64BitValueOf: intValue) to: 'short'.
					interpreterProxy failed ifTrue: [^nil].
					self cCode: 'buffer = malloc(sizeof(short));
						*(short*) buffer = (short) aValue']
			ifFalse: [aValue := self cCoerce: (interpreterProxy positive64BitValueOf: intValue) to: 'unsigned short'.
					interpreterProxy failed ifTrue: [^nil].
					self cCode: 'buffer = malloc(sizeof(unsigned short));
					*(unsigned short*)buffer = (unsigned short) aValue'].
	self touch: nsInvocationInstance.
	self touch: buffer.
	self cCode: '    NS_DURING'. 
	self cCode:  '[nsInvocationInstance setArgument: buffer atIndex: index]'.
	self cCode: '    NS_HANDLER'.
		interpreterProxy success: false.
		true ifTrue: [^nil].
	self cCode: '    NS_ENDHANDLER'.
	^interpreterProxy positive64BitIntegerFor: (self cCoerce: buffer to: 'usqInt') 