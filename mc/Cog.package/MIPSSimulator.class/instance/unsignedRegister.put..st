registers
unsignedRegister: registerNumber put: unsignedValue
	registerNumber == ZR ifFalse:
		[^registers at: registerNumber + 1 put: (self unsigned32ToSigned32: unsignedValue)].