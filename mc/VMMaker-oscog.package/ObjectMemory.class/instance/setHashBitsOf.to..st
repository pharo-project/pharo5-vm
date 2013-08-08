header access
setHashBitsOf: oop to: hash
	self longAt: oop
		put: (((self baseHeader: oop) bitClear: HashBits)
				bitOr: (hash bitAnd: HashMaskUnshifted) << HashBitsOffset)