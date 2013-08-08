system primitives
primitiveNSInvocationGetArgument: aMethodSignatureOop buffer: bufferOop atIndex: index
	|  nsInvocationInstance buffer |
	self primitive: 'primitiveNSInvocationGetArgument'
		parameters: #(Oop Oop SmallInteger).
	self var: 'nsInvocationInstance' declareC: 'NSInvocation* nsInvocationInstance'.
	self var: 'buffer' declareC: 'void * buffer'.

	nsInvocationInstance := self cCoerce: (interpreterProxy positive64BitValueOf: aMethodSignatureOop) to: 'NSInvocation *'.
	buffer := self cCoerce: (interpreterProxy positive64BitValueOf: bufferOop) to: 'void *'.
	interpreterProxy failed ifTrue: [^nil].
	self touch: nsInvocationInstance.
	self touch: buffer.
	self cCode: '    NS_DURING'. 
	self cCode:  '[nsInvocationInstance getArgument: buffer atIndex: index]'.
	self cCode: '    NS_HANDLER'.
		interpreterProxy success: false.
		true ifTrue: [^nil].
	self cCode: '    NS_ENDHANDLER'.
	^self