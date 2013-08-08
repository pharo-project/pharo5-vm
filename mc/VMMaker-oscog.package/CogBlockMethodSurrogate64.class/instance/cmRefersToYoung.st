accessing
cmRefersToYoung
	^(((memory unsignedByteAt: address + 10) bitShift: -3) bitAnd: 16r1) ~= 0