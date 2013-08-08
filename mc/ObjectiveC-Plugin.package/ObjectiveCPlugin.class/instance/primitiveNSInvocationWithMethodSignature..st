system primitives
primitiveNSInvocationWithMethodSignature: aMethodSignatureOop
	|  methodSignatureOop nsInvocationOops |
	self primitive: 'primitiveNSInvocationWithMethodSignature'
		parameters: #(Oop).
	self var: 'methodSignatureOop' declareC: 'NSMethodSignature * methodSignatureOop'.
	self var: 'nsInvocationOops' declareC: 'NSInvocation* nsInvocationOops'.

	methodSignatureOop := self cCoerce: (interpreterProxy positive64BitValueOf: aMethodSignatureOop) to: 'NSMethodSignature *'.
	interpreterProxy failed ifTrue: [^nil].
	nsInvocationOops := 0.
	self cCode: '    NS_DURING'. 
	self cCode:  'nsInvocationOops = [NSInvocation invocationWithMethodSignature: methodSignatureOop]'.
	self cCode: '    NS_HANDLER'.
		interpreterProxy success: false.
		true ifTrue: [^nil].
	self cCode: '    NS_ENDHANDLER'.
	^interpreterProxy positive64BitIntegerFor: (self cCoerce: nsInvocationOops to: 'usqInt') 
