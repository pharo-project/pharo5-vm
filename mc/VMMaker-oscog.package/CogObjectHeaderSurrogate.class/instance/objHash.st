accessing
objHash
	^(memory unsignedLongAt: address + 5) bitAnd: 16rFFFFFF