system primitives
primitiveSELGetName: aSEL
	|  stringOop bufferPointer |
	self primitive: 'primitiveSELGetName'
		parameters: #(Oop).
	self var: 'bufferPointer' declareC: 'SEL bufferPointer'.
	self cCode: '#define selgetName sel_getName
'.
	bufferPointer := self cCoerce: (interpreterProxy positive64BitValueOf: aSEL) to: 'SEL'.
	interpreterProxy failed ifTrue: [^nil].
	stringOop := self stringFromCString: (self selgetName: bufferPointer).
	^stringOop
