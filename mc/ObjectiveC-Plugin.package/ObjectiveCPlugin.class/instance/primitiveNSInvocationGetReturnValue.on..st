system primitives
primitiveNSInvocationGetReturnValue: bufferAddressOop on: aNSinvokeOops
	|  buffer nsInvoke |
	self primitive: 'primitiveNSInvocationGetReturnValue'
		parameters: #(Oop Oop).
	self var: 'buffer' declareC: 'void * buffer'.
	self var: 'nsInvoke' declareC: 'NSInvocation *nsInvoke'.

	buffer := self cCoerce: (interpreterProxy positive64BitValueOf: bufferAddressOop) to: 'void *'.
	nsInvoke := self cCoerce: (interpreterProxy positive64BitValueOf: aNSinvokeOops) to: 'NSInvocation *'.
	interpreterProxy failed ifTrue: [^nil].
	self touch: buffer.
	self cCode: '    NS_DURING'. 
	self cCode:  '[nsInvoke getReturnValue: buffer]'.
	self cCode: '    NS_HANDLER'.
		interpreterProxy success: false.
		true ifTrue: [^nil].
	self cCode: '    NS_ENDHANDLER'.
	^self