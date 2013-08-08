system primitives
primitiveMethodSignatureGetMethodReturnLength: aMethodSignatureOop
	|  nsMethodSignatureObject methodReturnLength |
	self primitive: 'primitiveMethodSignatureGetMethodReturnLength'
		parameters: #(Oop).
	self var: 'nsMethodSignatureObject' declareC: 'NSMethodSignature* nsMethodSignatureObject'.
	self var: 'methodReturnLength' declareC: 'NSUInteger methodReturnLength'.

	nsMethodSignatureObject := self cCoerce: (interpreterProxy positive64BitValueOf: aMethodSignatureOop) to: 'NSMethodSignature *'.
	methodReturnLength := 0.
	interpreterProxy failed ifTrue: [^nil].
	self touch: nsMethodSignatureObject.
	self cCode: '    NS_DURING'. 
	self cCode: 'methodReturnLength = [nsMethodSignatureObject methodReturnLength]'.
	self cCode: '    NS_HANDLER 
		methodReturnLength = 0xFFFFFFFF'.
	self cCode: '    NS_ENDHANDLER'.
	methodReturnLength = 16rFFFFFFFF
		ifTrue: [interpreterProxy success: false.
		^nil].
	^interpreterProxy positive64BitIntegerFor: (self cCoerce: methodReturnLength to: 'usqInt') 
