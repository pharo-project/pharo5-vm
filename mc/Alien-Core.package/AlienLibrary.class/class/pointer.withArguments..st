callouts
pointer: aString withArguments: anArray 
	| result |
	result := Alien forPointer: 0.
	(self lookup: aString) 
		primFFICallResult: result
		withArguments: anArray.
	^ result