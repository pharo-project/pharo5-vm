contexts
fetchContextRegisters: activeCntx 
	"Note: internalFetchContextRegisters: should track changes  to this method."
	| tmp |
	<inline: true>
	tmp := self fetchPointer: MethodIndex ofObject: activeCntx.
	(self isIntegerObject: tmp)
		ifTrue: ["if the MethodIndex field is an integer, activeCntx is a block context"
			tmp := self fetchPointer: HomeIndex ofObject: activeCntx.
			(self oop: tmp isLessThan: youngStart) ifTrue: [self beRootIfOld: tmp]]
		ifFalse: ["otherwise, it is a method context and is its own home context "
			tmp := activeCntx].
	theHomeContext := tmp.
	receiver := self fetchPointer: ReceiverIndex ofObject: tmp.
	method := self fetchPointer: MethodIndex ofObject: tmp.

	"the instruction pointer is a pointer variable equal to 
	method oop + ip + BaseHeaderSize 
	-1 for 0-based addressing of fetchByte 
	-1 because it gets incremented BEFORE fetching currentByte "
	tmp := self quickFetchInteger: InstructionPointerIndex ofObject: activeCntx.
	instructionPointer := method + tmp + self baseHeaderSize - 2.

	"the stack pointer is a pointer variable also..."
	tmp := self quickFetchInteger: StackPointerIndex ofObject: activeCntx.
	stackPointer := activeCntx + self baseHeaderSize + (TempFrameStart + tmp - 1 * self wordSize)