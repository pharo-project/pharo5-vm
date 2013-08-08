callouts
int: aString withArguments: anArray
	| result |
	result := Alien new: Alien sizeofInt.
	(self lookup: aString) 
		primFFICallResult: result
		withArguments: anArray.
	^ result asSignedInt