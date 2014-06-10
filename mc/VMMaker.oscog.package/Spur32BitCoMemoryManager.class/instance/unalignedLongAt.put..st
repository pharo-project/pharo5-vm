simulation only
unalignedLongAt: byteAddress put: aLong
	<doNotGenerate>
	| rem mask |
	rem := byteAddress \\ 4.
	^rem = 0
		ifTrue: [self longAt: byteAddress put: aLong]
		ifFalse:
			[mask := 16rFFFFFFFF bitAnd: (-1 bitShift: rem * 8).
			 self longAt: byteAddress - rem
				put: ((self longAt: byteAddress - rem) bitAnd: mask bitInvert)
					+ ((aLong bitShift: rem * 8) bitAnd: mask).
			 self longAt: byteAddress - rem + 4
				put: ((self longAt: byteAddress - rem + 4) bitAnd: mask)
					+ ((aLong bitShift: 4 - rem * -8) bitAnd: mask bitInvert).
			 aLong]