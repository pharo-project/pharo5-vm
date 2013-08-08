system primitives
primitiveNSInvocationSetLongType: aMethodSignatureOop signed: signedBoolean index: index value: intValue
	|  nsInvocationInstance buffer aValue |
	self primitive: 'primitiveNSInvocationSetLongType'
		parameters: #(Oop Boolean SmallInteger Oop).
	self var: 'nsInvocationInstance' declareC: 'NSInvocation* nsInvocationInstance'.
	self var: 'aValue' declareC: 'long aValue'.
	self var: 'buffer' declareC: 'void * buffer'.

	nsInvocationInstance := self cCoerce: (interpreterProxy positive64BitValueOf: aMethodSignatureOop) to: 'NSInvocation *'.
	interpreterProxy failed ifTrue: [^nil].
	signedBoolean 
			ifTrue: [aValue := self cCoerce: (interpreterProxy signed64BitValueOf: intValue) to: 'long'.
					interpreterProxy failed ifTrue: [^nil].
					self cCode: 'buffer = malloc(sizeof(long));
						*(long*) buffer = (long) aValue']
			ifFalse: [aValue := self cCoerce: (interpreterProxy positive64BitValueOf: intValue) to: 'unsigned long'.
					interpreterProxy failed ifTrue: [^nil].
					self cCode: 'buffer = malloc(sizeof(unsigned long));
					*(unsigned long*)buffer = (unsigned long) aValue'].
	self touch: nsInvocationInstance.
	self touch: buffer.
	self cCode: '    NS_DURING'. 
	self cCode:  '[nsInvocationInstance setArgument: buffer atIndex: index]'.
	self cCode: '    NS_HANDLER'.
		interpreterProxy success: false.
		true ifTrue: [^nil].
	self cCode: '    NS_ENDHANDLER'.
	^interpreterProxy positive64BitIntegerFor: (self cCoerce: buffer to: 'usqInt') 