accessing
stackCheckOffset
	^((memory unsignedShortAt: address + 3 + baseHeaderSize) bitShift: -4) bitAnd: 16rFFF