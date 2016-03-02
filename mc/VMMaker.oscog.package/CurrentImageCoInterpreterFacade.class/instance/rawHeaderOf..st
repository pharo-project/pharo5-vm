accessing
rawHeaderOf: aMethodOop
	| method headerOop |
	method := self objectForOop: aMethodOop.
	headerOop := objectMemory integerObjectOf: (self objectForOop: aMethodOop) header.
	self assert: method header = (headerToMethodMap at: headerOop ifAbsentPut: [method]) header.
	^headerOop