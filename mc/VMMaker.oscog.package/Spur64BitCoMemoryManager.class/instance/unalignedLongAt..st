simulation only
unalignedLongAt: byteAddress
	<doNotGenerate>
	| rem |
	rem := byteAddress \\ 8.
	^rem = 0
		ifTrue: [self longAt: byteAddress]
		ifFalse: [((self longAt: byteAddress - rem) + ((self longAt: byteAddress - rem + 8) bitShift: 64) bitShift: rem * -8) bitAnd: 16rFFFFFFFFFFFFFFFF]