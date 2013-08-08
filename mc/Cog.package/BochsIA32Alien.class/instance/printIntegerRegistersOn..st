printing
printIntegerRegistersOn: aStream
	self printRegisterState: self integerRegisterState on: aStream.
	aStream flush