accessing
cmIsUnlinked
	^(((memory unsignedByteAt: address + 10) bitShift: -4) bitAnd: 16r1) ~= 0