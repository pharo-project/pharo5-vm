accessing
cmUsesPenultimateLit
	^((memory unsignedByteAt: address + 7) bitAnd: 16r1) ~= 0