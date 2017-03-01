accessing
receiverTagBitsForMethod: methodOop
	^(self objectForOop: methodOop) methodClass =SmallInteger
		ifTrue: [1]
		ifFalse: [0]