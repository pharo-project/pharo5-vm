registers
signedRegister: registerNumber
	registerNumber == ZR ifTrue: [^0] ifFalse: [^registers at: registerNumber + 1].