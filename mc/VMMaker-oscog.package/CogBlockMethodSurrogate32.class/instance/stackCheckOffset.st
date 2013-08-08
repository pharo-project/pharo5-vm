accessing
stackCheckOffset
	^((memory unsignedShortAt: address + 7) bitShift: -4) bitAnd: 16rFFF