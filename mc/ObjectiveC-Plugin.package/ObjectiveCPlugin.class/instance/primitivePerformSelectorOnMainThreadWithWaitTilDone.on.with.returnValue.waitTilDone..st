system primitives
primitivePerformSelectorOnMainThreadWithWaitTilDone: aSelectorOop on: aClassOrInstanceOop with: anObject1 returnValue: aReturnValueAddress waitTilDone: doneFlag
	|  classOrInstanceObject  selectorObject object1 returnAddress |
	"- (id)performSelector:(SEL)aSelector"

	self primitive: 'primitivePerformSelectorOnMainThreadWithWaitTilDone'
		parameters: #(Oop Oop Oop Oop Boolean).
	self var: 'classOrInstanceObject' declareC: 'id classOrInstanceObject'.
	self var: 'object1' declareC: 'id object1'.
	self var: 'selectorObject' declareC: 'SEL selectorObject'.
	self var: 'returnAddress' declareC: 'void *returnAddress'.

	classOrInstanceObject := self cCoerce: (interpreterProxy positive64BitValueOf: aClassOrInstanceOop) to: 'id'.
	selectorObject := self cCoerce: (interpreterProxy positive64BitValueOf: aSelectorOop) to: 'SEL'.
	object1 := self cCoerce: (interpreterProxy positive64BitValueOf: anObject1) to: 'id'.
	returnAddress := self cCoerce: (interpreterProxy positive64BitValueOf: aReturnValueAddress) to: 'void *'.
	interpreterProxy failed ifTrue: [^nil].
	self touch: classOrInstanceObject.
	self touch: selectorObject.
	self touch: object1.
	self touch: returnAddress.
	self cCode: '    NS_DURING'. 
	self cCode:  '[classOrInstanceObject performSelectorOnMainThread: selectorObject withObject: object1 waitUntilDone: doneFlag  ]'.
	self cCode: '    NS_HANDLER'.
		interpreterProxy success: false.
		true ifTrue: [^nil].
	self cCode: '    NS_ENDHANDLER'.
	self cCode: '    NS_DURING'. 
	returnAddress ~= 0 ifTrue:
		[self cCode: '[classOrInstanceObject getReturnValue: returnAddress]'].
	self cCode: '    NS_HANDLER'.
		interpreterProxy success: false.
		true ifTrue: [^nil].
	self cCode: '    NS_ENDHANDLER'.
	^self