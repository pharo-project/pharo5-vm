compiled methods
argumentCountOfMethodHeader: header
	^ (header >> 25) bitAnd: 16r0F