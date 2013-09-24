memory access
longAt: byteAddress put: a32BitValue
	"Note: Adjusted for Smalltalk's 1-based array indexing."
	"(byteAddress = 16r11D8240 and: [a32BitValue = 16r1D8368]) ifTrue:
		[self halt]."
	byteAddress \\ 4 ~= 0 ifTrue: [self unalignedAccessError].
	^memory at: byteAddress // 4 + 1 put: a32BitValue