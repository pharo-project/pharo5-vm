system primitives
primitiveNSInvocationSetFloatType: aMethodSignatureOop  index: index value: aValue
	|  nsInvocationInstance buffer |
	self primitive: 'primitiveNSInvocationSetFloatType'
		parameters: #(Oop SmallInteger Float).
	self var: 'nsInvocationInstance' declareC: 'NSInvocation* nsInvocationInstance'.
	self var: 'aValue' declareC: 'float aValue'.
	self var: 'buffer' declareC: 'void * buffer'.

	nsInvocationInstance := self cCoerce: (interpreterProxy positive64BitValueOf: aMethodSignatureOop) to: 'NSInvocation *'.
	interpreterProxy failed ifTrue: [^nil].
	self cCode: 'buffer = malloc(sizeof(float));
				*(float*) buffer = (float) aValue'.
	self touch: nsInvocationInstance.
	self touch: buffer.
	self cCode: '    NS_DURING'. 
	self cCode:  '[nsInvocationInstance setArgument: buffer atIndex: index]'.
	self cCode: '    NS_HANDLER'.
		interpreterProxy success: false.
		true ifTrue: [^nil].
	self cCode: '    NS_ENDHANDLER'.
	^interpreterProxy positive64BitIntegerFor: (self cCoerce: buffer to: 'usqInt') 