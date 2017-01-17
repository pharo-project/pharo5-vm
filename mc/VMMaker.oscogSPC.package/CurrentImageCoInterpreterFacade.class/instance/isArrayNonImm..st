testing
isArrayNonImm: anOop
	^(self objectForOop: anOop) class instSpec = Array instSpec