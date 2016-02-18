memory access
longAt: byteAddress put: a32BitValue
	"Note: Adjusted for Smalltalk's 1-based array indexing."
	"(byteAddress = 16r101348 and: [a32BitValue = 16r53]) ifTrue:
		[self halt]."
	"((byteAddress between: 16rda8ac and: 16rda8c0)
	 or: [byteAddress between: 16r8eb98 and: 16r8ebb0]) ifTrue:
		[self halt]."
	byteAddress \\ 4 ~= 0 ifTrue: [self unalignedAccessError].
	^memory at: byteAddress // 4 + 1 put: a32BitValue