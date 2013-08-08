system primitives
primitiveGetClass: aClassOrInstanceOop
	|  classOrInstanceObject classObject |
	self primitive: 'primitiveGetClass'
		parameters: #(Oop).
	self var: 'classOrInstanceObject' declareC: 'id classOrInstanceObject'.
	self var: 'classObject' declareC: 'Class classObject'.

	classOrInstanceObject := self cCoerce: (interpreterProxy positive64BitValueOf: aClassOrInstanceOop) to: 'id'.
	classObject := nil.
	interpreterProxy failed ifTrue: [^nil].
	self touch: classOrInstanceObject.
	self touch: classObject.
	self cCode: '    NS_DURING'. 
	self cCode:  'classObject = [classOrInstanceObject class]'.
	self cCode: '    NS_HANDLER 
		classObject = nil;'.
	self cCode: '    NS_ENDHANDLER'.
	^interpreterProxy positive64BitIntegerFor: (self cCoerce: classObject to: 'usqInt') 