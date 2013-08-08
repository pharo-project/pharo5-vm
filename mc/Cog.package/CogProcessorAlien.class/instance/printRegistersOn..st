printing
printRegistersOn: aStream
	self printRegisterState: self registerState on: aStream.
	aStream flush