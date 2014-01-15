accessing
isMarked
	^(((memory unsignedByteAt: address + 4) bitShift: -5) bitAnd: 16r1) ~= 0