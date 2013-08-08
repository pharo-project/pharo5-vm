memory access
unalignedLongAt: byteAddress
	| rem |
	rem := byteAddress \\ 4.
	^rem = 0
		ifTrue: [self longAt: byteAddress]
		ifFalse: [((self longAt: byteAddress - rem) + ((self longAt: byteAddress - rem + 4) bitShift: 32) bitShift: rem * -8) bitAnd: 16rFFFFFFFF]