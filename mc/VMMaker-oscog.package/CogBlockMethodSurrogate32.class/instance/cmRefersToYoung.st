accessing
cmRefersToYoung
	^(((memory unsignedByteAt: address + 6) bitShift: -3) bitAnd: 16r1) ~= 0