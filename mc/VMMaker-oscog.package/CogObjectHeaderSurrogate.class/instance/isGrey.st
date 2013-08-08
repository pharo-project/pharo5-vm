accessing
isGrey
	^(((memory unsignedByteAt: address + 4) bitShift: -6) bitAnd: 16r1) ~= 0