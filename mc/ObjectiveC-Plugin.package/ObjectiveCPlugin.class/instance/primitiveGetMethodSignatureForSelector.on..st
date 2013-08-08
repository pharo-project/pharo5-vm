system primitives
primitiveGetMethodSignatureForSelector: aSelectorOop on: aClassOrInstanceOop
	|  selectorObject classOrInstanceObject messageSignatureObject |
	self primitive: 'primitiveGetMethodSignatureForSelector'
		parameters: #(Oop Oop).
	self var: 'selectorObject' declareC: 'SEL selectorObject'.
	self var: 'classOrInstanceObject' declareC: 'id classOrInstanceObject'.
	self var: 'messageSignatureObject' declareC: 'NSMethodSignature * messageSignatureObject'.

	selectorObject := self cCoerce: (interpreterProxy positive64BitValueOf: aSelectorOop) to: 'SEL'.
	classOrInstanceObject := self cCoerce: (interpreterProxy positive64BitValueOf: aClassOrInstanceOop) to: 'id'.
	messageSignatureObject := nil.
	interpreterProxy failed ifTrue: [^nil].
	self touch: classOrInstanceObject.
	self touch: selectorObject.
	self cCode: '    NS_DURING'. 
	self cCode:  'messageSignatureObject = [classOrInstanceObject methodSignatureForSelector: selectorObject]'.
	self cCode: '    NS_HANDLER 
	messageSignatureObject = nil;'.
	self cCode: '    NS_ENDHANDLER'.
	^interpreterProxy positive64BitIntegerFor: (self cCoerce: messageSignatureObject to: 'usqInt') 