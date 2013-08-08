callouts
void: aString withArguments: anArray 
	(self lookup: aString) 
		primFFICallResult: nil
		withArguments: anArray