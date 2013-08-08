instance creation
fromUnsigned: anInteger

	^(super new: 1) 
		at: 1 put: anInteger;
		yourself