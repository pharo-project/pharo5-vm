header access
hashBitsOf: oop

	^ ((self baseHeader: oop) >> HashBitsOffset) bitAnd: HashMaskUnshifted