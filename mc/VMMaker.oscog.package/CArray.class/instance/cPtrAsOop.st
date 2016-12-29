accessing
cPtrAsOop
	ptrOffset = 0 ifFalse: [self error: 'offset must be zero'].
	^arrayBaseAddress - interpreter baseHeaderSize