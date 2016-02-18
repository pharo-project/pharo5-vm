registers
unsignedRegister: registerNumber
	registerNumber == ZR 
		ifTrue: [^0]
		ifFalse: [^self signed32ToUnsigned32: (registers at: registerNumber + 1)].