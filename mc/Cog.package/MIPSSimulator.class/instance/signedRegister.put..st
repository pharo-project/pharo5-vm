registers
signedRegister: registerNumber put: signedValue
	self assert: (signedValue between: -16r80000000 and: 16r7FFFFFFF).
	registerNumber == ZR ifFalse: [^registers at: registerNumber + 1 put: signedValue].