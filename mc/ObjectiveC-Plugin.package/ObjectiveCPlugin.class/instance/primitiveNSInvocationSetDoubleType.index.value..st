system primitives
primitiveNSInvocationSetDoubleType: aMethodSignatureOop  index: index value: aValue
	|  nsInvocationInstance buffer |
	self primitive: 'primitiveNSInvocationSetDoubleType'
		parameters: #(Oop SmallInteger Float).
	self var: 'nsInvocationInstance' declareC: 'NSInvocation* nsInvocationInstance'.
	self var: 'aValue' declareC: 'double aValue'.
	self var: 'buffer' declareC: 'void * buffer'.

	nsInvocationInstance := self cCoerce: (interpreterProxy positive64BitValueOf: aMethodSignatureOop) to: 'NSInvocation *'.
	interpreterProxy failed ifTrue: [^nil].
	self cCode: 'buffer = malloc(sizeof(double));
				*(double*) buffer = (double) aValue'.
	self touch: nsInvocationInstance.
	self touch: buffer.
	self cCode: '    NS_DURING'. 
	self cCode:  '[nsInvocationInstance setArgument: buffer atIndex: index]'.
	self cCode: '    NS_HANDLER'.
		interpreterProxy success: false.
		true ifTrue: [^nil].
	self cCode: '    NS_ENDHANDLER'.
	^interpreterProxy positive64BitIntegerFor: (self cCoerce: buffer to: 'usqInt') 