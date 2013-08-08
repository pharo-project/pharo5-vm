system primitives
primitiveNSLog: aNSStringOOP
	|  oop1 |
	self primitive: 'primitiveNSLog'
		parameters: #(Oop).
	self var: 'oop1' declareC: 'id oop1'.
	
	oop1 := self cCoerce: (interpreterProxy positive64BitValueOf: aNSStringOOP) to: 'id'.
	interpreterProxy failed ifTrue: [^nil].
	self touch: oop1.
	self NSLog: oop1.
