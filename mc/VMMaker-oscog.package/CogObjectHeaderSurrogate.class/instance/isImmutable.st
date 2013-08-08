accessing
isImmutable
	^(((memory unsignedByteAt: address + 3) bitShift: -7) bitAnd: 16r1) ~= 0