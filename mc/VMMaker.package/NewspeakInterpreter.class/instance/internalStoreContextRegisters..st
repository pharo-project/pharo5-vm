contexts
internalStoreContextRegisters: activeCntx
	"The only difference between this method and fetchContextRegisters: is that this method stores from the local IP and SP."

	"InstructionPointer is a pointer variable equal to
	method oop + ip + BaseHeaderSize
		-1 for 0-based addressing of fetchByte
		-1 because it gets incremented BEFORE fetching currentByte"

	<inline: true>
	self storePointerUnchecked: InstructionPointerIndex ofObject: activeCntx
		withValue: (self integerObjectOf: 
			((self oopForPointer: localIP) + 2 - (method + BaseHeaderSize))).
	self storePointerUnchecked: StackPointerIndex		  ofObject: activeCntx
		withValue: (self integerObjectOf:
			((((self oopForPointer: localSP) - (activeCntx + BaseHeaderSize)) >> ShiftForWord) - TempFrameStart + 1)).
