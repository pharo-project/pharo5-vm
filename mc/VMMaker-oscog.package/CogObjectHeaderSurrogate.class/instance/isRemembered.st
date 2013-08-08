accessing
isRemembered
	^(((memory unsignedByteAt: address + 4) bitShift: -7) bitAnd: 16r1) ~= 0