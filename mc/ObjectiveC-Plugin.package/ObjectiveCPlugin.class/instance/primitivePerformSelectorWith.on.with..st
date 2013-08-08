system primitives
primitivePerformSelectorWith: aSelectorOop on: aClassOrInstanceOop with: anObject1
	|  classOrInstanceObject  selectorObject returnValue object1 |
	"- (id)performSelector:(SEL)aSelector"

	self primitive: 'primitivePerformSelectorWith'
		parameters: #(Oop Oop Oop).
	self var: 'classOrInstanceObject' declareC: 'id classOrInstanceObject'.
	self var: 'object1' declareC: 'id object1'.
	self var: 'selectorObject' declareC: 'SEL selectorObject'.
	self var: 'returnValue' declareC: 'id returnValue'.

	classOrInstanceObject := self cCoerce: (interpreterProxy positive64BitValueOf: aClassOrInstanceOop) to: 'id'.
	selectorObject := self cCoerce: (interpreterProxy positive64BitValueOf: aSelectorOop) to: 'SEL'.
	object1 := self cCoerce: (interpreterProxy positive64BitValueOf: anObject1) to: 'id'.
	interpreterProxy failed ifTrue: [^nil].
	returnValue := nil.
	self touch: classOrInstanceObject.
	self touch: selectorObject.
	self touch: object1.
	self cCode: '    NS_DURING'. 
	self cCode:  'returnValue = [classOrInstanceObject performSelector: selectorObject withObject: object1]'.
	self cCode: '    NS_HANDLER 
		returnValue = nil;'.
	self cCode: '    NS_ENDHANDLER'.
	^interpreterProxy positive64BitIntegerFor: (self cCoerce: returnValue to: 'usqInt') 