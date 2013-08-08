system primitives
primitivePerformSelector: aSelectorOop on: aClassOrInstanceOop
	|  classOrInstanceObject  selectorObject returnValue |
	"- (id)performSelector:(SEL)aSelector"

	self primitive: 'primitivePerformSelector'
		parameters: #(Oop Oop).
	self var: 'classOrInstanceObject' declareC: 'id classOrInstanceObject'.
	self var: 'selectorObject' declareC: 'SEL selectorObject'.
	self var: 'returnValue' declareC: 'id returnValue'.

	classOrInstanceObject := self cCoerce: (interpreterProxy positive64BitValueOf: aClassOrInstanceOop) to: 'id'.
	selectorObject := self cCoerce: (interpreterProxy positive64BitValueOf: aSelectorOop) to: 'SEL'.
	interpreterProxy failed ifTrue: [^nil].
	returnValue := nil.
	self touch: classOrInstanceObject.
	self touch: selectorObject.
	self cCode: '    NS_DURING'. 
	self cCode:  'returnValue = [classOrInstanceObject performSelector: selectorObject]'.
	self cCode: '    NS_HANDLER 
		returnValue = nil;'.
	self cCode: '    NS_ENDHANDLER'.
	^interpreterProxy positive64BitIntegerFor: (self cCoerce: returnValue to: 'usqInt') 