object testing
isClassOfNonImm: objOop equalTo: classOop
	^(self classIndexOf: objOop) = (self rawHashBitsOf: classOop)