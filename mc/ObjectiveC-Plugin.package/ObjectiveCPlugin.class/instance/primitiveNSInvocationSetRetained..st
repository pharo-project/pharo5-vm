system primitives
primitiveNSInvocationSetRetained: aMethodSignatureOop
	|  nsInvocationInstance |
	self primitive: 'primitiveNSInvocationSetRetained'
		parameters: #(Oop).
	self var: 'nsInvocationInstance' declareC: 'NSInvocation* nsInvocationInstance'.

	nsInvocationInstance := self cCoerce: (interpreterProxy positive64BitValueOf: aMethodSignatureOop) to: 'NSInvocation *'.
	interpreterProxy failed ifTrue: [^nil].
	self cCode: '    NS_DURING'. 
	self cCode:  '[nsInvocationInstance retainArguments]'.
	self cCode: '    NS_HANDLER'.
		interpreterProxy success: false.
	self cCode: '    NS_ENDHANDLER'.
