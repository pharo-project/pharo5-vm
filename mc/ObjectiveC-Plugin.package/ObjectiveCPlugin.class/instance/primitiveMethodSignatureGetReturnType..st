system primitives
primitiveMethodSignatureGetReturnType: aMethodSignatureOop
	|  nsMethodSignatureObject string stringOop |
	self primitive: 'primitiveMethodSignatureGetReturnType'
		parameters: #(Oop).
	self var: 'nsMethodSignatureObject' declareC: 'NSMethodSignature* nsMethodSignatureObject'.
	self var: 'string' declareC: 'const char * string'.

	nsMethodSignatureObject := self cCoerce: (interpreterProxy positive64BitValueOf: aMethodSignatureOop) to: 'NSMethodSignature *'.
	string := nil.
	interpreterProxy failed ifTrue: [^nil].
	self touch: nsMethodSignatureObject.
	self cCode: '    NS_DURING'. 
	self cCode:  'string = [nsMethodSignatureObject methodReturnType]'.
	self cCode: '    NS_HANDLER 
		string = nil;'.
	self cCode: '    NS_ENDHANDLER'.
	string
		ifFalse: [interpreterProxy success: false.
		^nil].
	stringOop := self stringFromCString: string.
	^stringOop
