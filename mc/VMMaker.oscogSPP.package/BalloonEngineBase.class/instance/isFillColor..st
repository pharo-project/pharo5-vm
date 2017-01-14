testing
isFillColor: fill
	^((self makeUnsignedFrom: fill) bitAnd: 16rFF000000) ~= 0