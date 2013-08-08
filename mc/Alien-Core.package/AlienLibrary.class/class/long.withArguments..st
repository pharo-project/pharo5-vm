callouts
long: aString withArguments: anArray
	| result |
	result := Alien new: Alien sizeofLong.
	(self lookup: aString) 
		primFFICallResult: result
		withArguments: anArray.
	^ result asSignedLong