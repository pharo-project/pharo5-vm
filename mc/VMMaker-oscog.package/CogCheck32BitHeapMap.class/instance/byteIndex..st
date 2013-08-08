accessing
byteIndex: address 
	^((address bitShift: -2) bitAnd: PageMask) + 1