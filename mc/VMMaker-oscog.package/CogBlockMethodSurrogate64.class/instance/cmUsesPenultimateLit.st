accessing
cmUsesPenultimateLit
	^((memory unsignedByteAt: address + 11) bitAnd: 16r1) ~= 0