callouts
double: aString withArguments: anArray 
	| result |
	result := Alien new: Alien sizeofDouble.
	(self lookup: aString) 
		primFFICallDoubleResult: result
		withArguments: anArray.
	^ result doubleAt: 1