testing
isWithinMwOffsetRange: anAddress
	"Answer if an address can be accessed using the offset in a MoveMw:r:R: or similar instruction.
	 We assume this is true for 32-bit processors and expect 64-bit processors to answer false
	 for values in the interpreter or the object memory."

	^true