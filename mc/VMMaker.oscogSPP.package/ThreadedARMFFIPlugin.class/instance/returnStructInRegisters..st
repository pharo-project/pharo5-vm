marshalling
returnStructInRegisters: returnStructSize
	"Answer if a struct result of a given size is returned in memory or not."
	^returnStructSize <= 4