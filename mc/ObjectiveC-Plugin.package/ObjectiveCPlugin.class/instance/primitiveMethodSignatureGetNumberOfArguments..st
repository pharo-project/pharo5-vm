system primitives
primitiveMethodSignatureGetNumberOfArguments: aMethodSignatureOop
	|  nsMethodSignatureObject numberOfArguments |
	self primitive: 'primitiveMethodSignatureGetNumberOfArguments'
		parameters: #(Oop).
	self var: 'nsMethodSignatureObject' declareC: 'NSMethodSignature* nsMethodSignatureObject'.
	self var: 'numberOfArguments' declareC: 'NSUInteger numberOfArguments'.

	nsMethodSignatureObject := self cCoerce: (interpreterProxy positive64BitValueOf: aMethodSignatureOop) to: 'NSMethodSignature *'.
	numberOfArguments := 9999999.
	interpreterProxy failed ifTrue: [^nil].
	self touch: nsMethodSignatureObject.
	self cCode: '    NS_DURING'. 
	self cCode: 'numberOfArguments = [nsMethodSignatureObject numberOfArguments]'.
	self cCode: '    NS_HANDLER 
		numberOfArguments = 9999999'.
	self cCode: '    NS_ENDHANDLER'.
	numberOfArguments = 9999999
		ifTrue: [interpreterProxy success: false.
		^nil].
	^interpreterProxy positive64BitIntegerFor: (self cCoerce: numberOfArguments to: 'usqInt') 
