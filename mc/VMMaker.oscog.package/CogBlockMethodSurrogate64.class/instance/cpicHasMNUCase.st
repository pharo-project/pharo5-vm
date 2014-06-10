accessing
cpicHasMNUCase
	^(((memory unsignedByteAt: address + 2 + baseHeaderSize) bitShift: -4) bitAnd: 16r1) ~= 0