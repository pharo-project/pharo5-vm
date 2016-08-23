object testing
isClassOfNonImm: objOop equalTo: classOop
	<inline: true>
	self assert: (self isNonImmediate: objOop).
	^(self classIndexOf: objOop) = (self rawHashBitsOf: classOop)