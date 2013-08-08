instance creation
fromString: aString

	^(super new: 1) 
		fourBytesAt: 1 put: aString;
		yourself