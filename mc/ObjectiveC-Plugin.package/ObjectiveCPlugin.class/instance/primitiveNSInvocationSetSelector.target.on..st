system primitives
primitiveNSInvocationSetSelector: aSelectorOop target: object1Oops on: aNSinvokeOops
	|  selectorObject object1 nsInvoke |
	self primitive: 'primitiveNSInvocationSetSelector'
		parameters: #(Oop Oop Oop).

	self var: 'object1' declareC: 'id object1'.
	self var: 'selectorObject' declareC: 'SEL selectorObject'.
	self var: 'nsInvoke' declareC: 'NSInvocation *nsInvoke'.

	selectorObject := self cCoerce: (interpreterProxy positive64BitValueOf: aSelectorOop) to: 'SEL'.
	object1 := self cCoerce: (interpreterProxy positive64BitValueOf: object1Oops) to: 'id'.
	nsInvoke := self cCoerce: (interpreterProxy positive64BitValueOf: aNSinvokeOops) to: 'NSInvocation *'.
	interpreterProxy failed ifTrue: [^nil].
	self cCode: '    NS_DURING'. 
	self cCode:  '[nsInvoke setSelector: selectorObject]'.
	self cCode:  '[nsInvoke setTarget:  object1]'.
	self cCode: '    NS_HANDLER'.
		interpreterProxy success: false.
		true ifTrue: [^self].
	self cCode: '    NS_ENDHANDLER'.
	^self