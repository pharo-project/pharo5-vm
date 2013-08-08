system primitives
primitiveIsEqual: anOop1 to: anOop2
	|  oop1 oop2 result |
	self primitive: 'primitiveIsEqual'
		parameters: #(Oop Oop).
	self var: 'oop1' declareC: 'id oop1'.
	self var: 'oop2' declareC: 'id oop2'.
	self var: 'result' declareC: 'BOOL result'.

	oop1 := self cCoerce: (interpreterProxy positive64BitValueOf: anOop1) to: 'id'.
	oop2 := self cCoerce: (interpreterProxy positive64BitValueOf: anOop2) to: 'id'.
	interpreterProxy failed ifTrue: [^nil].
	self touch: oop1.
	self touch: oop2.
	result := 0.
	self cCode: '    NS_DURING'. 
	self cCode:  'result = [oop1 isEqual: oop2]'.
	self cCode: '    NS_HANDLER'.
	interpreterProxy success: false.
	true ifTrue: [^nil].
	self cCode: '    NS_ENDHANDLER'.
	^(result = 1) asBooleanObj
