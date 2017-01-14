accessing
primitiveIndexOfMethod: anOop header: header
	| method |
	method := self objectForOop: anOop.
	self assert: (self objectForOop: header) = method header.
	^method primitive