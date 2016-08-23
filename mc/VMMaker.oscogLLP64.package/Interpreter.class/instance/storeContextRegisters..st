contexts
storeContextRegisters: activeCntx
	"Note: internalStoreContextRegisters: should track changes to this method."

	"InstructionPointer is a pointer variable equal to
	method oop + ip + BaseHeaderSize
		-1 for 0-based addressing of fetchByte
		-1 because it gets incremented BEFORE fetching currentByte"

	<inline: true>
	self storePointerUnchecked: InstructionPointerIndex ofObject: activeCntx
		withValue: (self integerObjectOf: (instructionPointer - method - (self baseHeaderSize - 2))).
	self storePointerUnchecked: StackPointerIndex ofObject: activeCntx
		withValue: (self integerObjectOf: (self stackPointerIndex - TempFrameStart + 1)).
