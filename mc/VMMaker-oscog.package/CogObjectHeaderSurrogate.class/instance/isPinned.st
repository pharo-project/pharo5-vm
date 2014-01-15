accessing
isPinned
	^(((memory unsignedByteAt: address + 3) bitShift: -6) bitAnd: 16r1) ~= 0