accessing
stackCheckOffset
	^((memory unsignedShortAt: address + 11) bitShift: -4) bitAnd: 16rFFF