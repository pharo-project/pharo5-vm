testing
isWithinMwOffsetRange: anAddress
	"Answer if an address can be accessed using the offset in a MoveMw:r:R: or similar instruction.
	 We assume this is true for 32-bit processors and expect 64-bit processors to answer false
	 for values in the interpreter or the object memory.    Restrict our use of offsets to reference
	 addresses within the method zone, rather than checking for a 32-bit offset, si as to keep the
	 simulator and real VM in sync."

	^cogit addressIsInCodeZone: anAddress