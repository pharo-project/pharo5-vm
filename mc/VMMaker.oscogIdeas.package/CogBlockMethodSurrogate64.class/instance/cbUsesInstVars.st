accessing
cbUsesInstVars
	^(((memory unsignedByteAt: address + 3 + baseHeaderSize) bitShift: -1) bitAnd: 16r1) ~= 0