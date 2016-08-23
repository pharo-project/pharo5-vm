accessing
byteIndex: address 
	^((address bitShift: ByteShift) bitAnd: PageMask) + 1