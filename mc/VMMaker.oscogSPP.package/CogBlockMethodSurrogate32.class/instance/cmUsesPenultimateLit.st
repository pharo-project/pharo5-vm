accessing
cmUsesPenultimateLit
	^((memory unsignedByteAt: address + 3 + baseHeaderSize) bitAnd: 16r1) ~= 0