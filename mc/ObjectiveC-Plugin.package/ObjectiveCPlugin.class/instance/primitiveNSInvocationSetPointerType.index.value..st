system primitives
primitiveNSInvocationSetPointerType: aMethodSignatureOop  index: index value: pointerValue
	|  nsInvocationInstance buffer aValue |
	self primitive: 'primitiveNSInvocationSetPointerType'
		parameters: #(Oop SmallInteger Oop).
	self var: 'nsInvocationInstance' declareC: 'NSInvocation* nsInvocationInstance'.
	self var: 'aValue' declareC: 'void * aValue'.
	self var: 'buffer' declareC: 'void ** buffer'.

	nsInvocationInstance := self cCoerce: (interpreterProxy positive64BitValueOf: aMethodSignatureOop) to: 'NSInvocation *'.
	aValue := self cCoerce: (interpreterProxy positive64BitValueOf: pointerValue) to: 'char *'.
	interpreterProxy failed ifTrue: [^nil].
	self cCode: 'buffer = malloc(sizeof(void*));
		*buffer = aValue'.
	self touch: nsInvocationInstance.
	self touch: buffer.
	self cCode: '    NS_DURING'. 
	self cCode:  '[nsInvocationInstance setArgument: buffer atIndex: index]'.
	self cCode: '    NS_HANDLER'.
		interpreterProxy success: false.
		true ifTrue: [^nil].
	self cCode: '    NS_ENDHANDLER'.
	^interpreterProxy positive64BitIntegerFor: (self cCoerce: buffer to: 'usqInt') 