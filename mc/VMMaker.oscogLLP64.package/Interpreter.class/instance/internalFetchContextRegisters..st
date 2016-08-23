contexts
internalFetchContextRegisters: activeCntx
	"Inlined into return bytecodes. The only difference between this method and fetchContextRegisters: is that this method sets the local IP and SP."

	| tmp |
	<inline: true>
	tmp := self fetchPointer: MethodIndex ofObject: activeCntx.
	(self isIntegerObject: tmp) ifTrue: [
		"if the MethodIndex field is an integer, activeCntx is a block context"
		tmp := self fetchPointer: HomeIndex ofObject: activeCntx.
		(self oop: tmp isLessThan: youngStart) ifTrue: [ self beRootIfOld: tmp ].
	] ifFalse: [
		"otherwise, it is a method context and is its own home context"
		tmp := activeCntx.
	].
	localHomeContext := tmp.
	receiver := self fetchPointer: ReceiverIndex ofObject: tmp.
	method := self fetchPointer: MethodIndex ofObject: tmp.

	"the instruction pointer is a pointer variable equal to
		method oop + ip + BaseHeaderSize
		  -1 for 0-based addressing of fetchByte
		  -1 because it gets incremented BEFORE fetching currentByte"
	tmp := self quickFetchInteger: InstructionPointerIndex ofObject: activeCntx.
	localIP := self pointerForOop: method + tmp + self baseHeaderSize - 2.

	"the stack pointer is a pointer variable also..."
	tmp := self quickFetchInteger: StackPointerIndex ofObject: activeCntx.
	localSP := self pointerForOop: activeCntx + self baseHeaderSize + ((TempFrameStart + tmp - 1) * self wordSize)