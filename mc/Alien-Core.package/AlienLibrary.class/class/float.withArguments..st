callouts
float: aString withArguments: anArray 
	| result |
	result := Alien new: Alien sizeofFloat.
	(self lookup: aString) 
		primFFICallResult: result
		withArguments: anArray.
	^ result floatAt: 1