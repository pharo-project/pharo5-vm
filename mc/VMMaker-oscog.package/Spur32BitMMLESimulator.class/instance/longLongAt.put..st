memory access
longLongAt: byteAddress put: a64BitValue
	"memory is a Bitmap, a 32-bit indexable array of bits"
	byteAddress \\ 8 ~= 0 ifTrue: [self unalignedAccessError].
	"(byteAddress = 16r11D8240 and: [(a64BitValue bitAnd: 16rffffffff) = 16r1D8368]) ifTrue:
		[self halt]."
	memory
		at: byteAddress // 4 + 1 put: (a64BitValue bitAnd: 16rffffffff);
		at: byteAddress // 4 + 2 put: a64BitValue >> 32.
	^a64BitValue