system primitives
primitiveNSInvocationSetStructureType: aMethodSignatureOop  index: index value: aValue
	|  nsInvocationInstance buffer byteArraySize |
	self primitive: 'primitiveNSInvocationSetStructureType'
		parameters: #(Oop SmallInteger ByteArray).
	self var: 'nsInvocationInstance' declareC: 'NSInvocation* nsInvocationInstance'.
	self var: 'buffer' declareC: 'void * buffer'.

	nsInvocationInstance := self cCoerce: (interpreterProxy positive64BitValueOf: aMethodSignatureOop) to: 'NSInvocation *'.
	interpreterProxy failed ifTrue: [^nil].
	byteArraySize := interpreterProxy slotSizeOf: aValue cPtrAsOop.
	self cCode: 'buffer = malloc(byteArraySize);
		memcpy(buffer,aValue,byteArraySize)'.
	self touch: nsInvocationInstance.
	self touch: buffer.
	self touch: byteArraySize.
	self cCode: '    NS_DURING'. 
	self cCode:  '[nsInvocationInstance setArgument: buffer atIndex: index]'.
	self cCode: '    NS_HANDLER'.
		interpreterProxy success: false.
		true ifTrue: [^nil].
	self cCode: '    NS_ENDHANDLER'.
	^interpreterProxy positive64BitIntegerFor: (self cCoerce: buffer to: 'usqInt') 