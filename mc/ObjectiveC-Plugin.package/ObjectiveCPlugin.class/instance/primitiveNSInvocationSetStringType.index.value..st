system primitives
primitiveNSInvocationSetStringType: aMethodSignatureOop  index: index value: aValue
	|  nsInvocationInstance buffer stringSize |
	self primitive: 'primitiveNSInvocationSetStringType'
		parameters: #(Oop SmallInteger String).
	self var: 'nsInvocationInstance' declareC: 'NSInvocation* nsInvocationInstance'.
	self var: 'aValue' declareC: 'char * aValue'.
	self var: 'buffer' declareC: 'char * buffer'.

	nsInvocationInstance := self cCoerce: (interpreterProxy positive64BitValueOf: aMethodSignatureOop) to: 'NSInvocation *'.
	interpreterProxy failed ifTrue: [^nil].
	stringSize := interpreterProxy slotSizeOf: aValue cPtrAsOop.
	self cCode: 'buffer = malloc(stringSize + 1);
		memcpy(buffer,aValue,stringSize);
		buffer[stringSize] = 0x00'.
	self touch: nsInvocationInstance.
	self touch: buffer.
	self cCode: '    NS_DURING'. 
	self cCode:  '[nsInvocationInstance setArgument: &buffer atIndex: index]'.
	self cCode: '    NS_HANDLER'.
		interpreterProxy success: false.
		true ifTrue: [^nil].
	self cCode: '    NS_ENDHANDLER'.
	^interpreterProxy positive64BitIntegerFor: (self cCoerce: buffer to: 'usqInt') 