accessing
cmIsUnlinked
	^(((memory unsignedByteAt: address + 6) bitShift: -4) bitAnd: 16r1) ~= 0