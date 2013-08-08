accessing
cPtrAsOop

	offset = 0 ifFalse: [self error: 'offset must be zero'].
	^object