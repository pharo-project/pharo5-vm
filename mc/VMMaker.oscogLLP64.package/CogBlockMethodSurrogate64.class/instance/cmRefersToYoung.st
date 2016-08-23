accessing
cmRefersToYoung
	^(((memory unsignedByteAt: address + 2 + baseHeaderSize) bitShift: -3) bitAnd: 16r1) ~= 0