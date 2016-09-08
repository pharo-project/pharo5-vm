memory access
long64At: byteAddress put: a64BitValue
	byteAddress \\ 8 ~= 0 ifTrue: [self unalignedAccessError].
	self
		long32At: byteAddress put: (a64BitValue bitAnd: 16rffffffff);
		long32At: byteAddress + 4 put: (a64BitValue >> 32 bitAnd: 16rffffffff).
	^a64BitValue