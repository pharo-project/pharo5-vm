system primitives
primitiveMethodSignatureGetArgumentType: aMethodSignatureOop atIndex: aIndexNumber
	|  nsMethodSignatureObject string stringOop |
	self primitive: 'primitiveMethodSignatureGetArgumentType'
		parameters: #(Oop SmallInteger).
	self var: 'nsMethodSignatureObject' declareC: 'NSMethodSignature* nsMethodSignatureObject'.
	self var: 'string' declareC: 'const char * string'.

	nsMethodSignatureObject := self cCoerce: (interpreterProxy positive64BitValueOf: aMethodSignatureOop) to: 'NSMethodSignature *'.
	string := nil.
	interpreterProxy failed ifTrue: [^nil].
	self touch: nsMethodSignatureObject.
	self cCode: '    NS_DURING'. 
	self cCode:  'string = [nsMethodSignatureObject getArgumentTypeAtIndex: aIndexNumber]'.
	self cCode: '    NS_HANDLER 
		string = nil;'.
	self cCode: '    NS_ENDHANDLER'.
	string
		ifFalse: [interpreterProxy success: false.
		^nil].
	stringOop := self stringFromCString: string.
	^stringOop
