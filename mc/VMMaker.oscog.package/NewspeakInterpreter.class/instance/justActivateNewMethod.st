callback support
justActivateNewMethod
	"Activate the new method but *do not* copy receiver or arguments from activeContext."
	| methodHeader initialIP newContext tempCount needsLarge where |
	<inline: true>

	methodHeader := self methodHeaderOf: newMethod.
	needsLarge := methodHeader bitAnd: LargeContextBit.
	(needsLarge = 0 and: [freeContexts ~= NilContext])
		ifTrue: [newContext := freeContexts.
				freeContexts := self fetchPointer: 0 ofObject: newContext]
		ifFalse: ["Slower call for large contexts or empty free list"
				newContext := self allocateOrRecycleContext: needsLarge].
	initialIP := ((LiteralStart + (self literalCountOfMethodHeader: methodHeader)) * self wordSize) + 1.
	tempCount := (methodHeader >> 19) bitAnd: 16r3F.

	"Assume: newContext will be recorded as a root if necessary by the
	 call to newActiveContext: below, so we can use unchecked stores."
	where := newContext + self baseHeaderSize.
	self longAt: where + (SenderIndex << self shiftForWord) put: activeContext.
	self longAt: where + (InstructionPointerIndex << self shiftForWord) put: (self integerObjectOf: initialIP).
	self longAt: where + (StackPointerIndex << self shiftForWord) put: (self integerObjectOf: tempCount).
	self longAt: where + (MethodIndex << self shiftForWord) put: newMethod.

	"Set the receiver..."
	self longAt: where + (ReceiverIndex << self shiftForWord) put: receiver.

	"clear all args and temps to nil in case it has been recycled"
	needsLarge := nilObj.  "needsLarge here used just as faster (register?) temp"
	ReceiverIndex + 1 to: tempCount + ReceiverIndex do:
		[:i | self longAt: where + (i << self shiftForWord) put: needsLarge].
	reclaimableContextCount := reclaimableContextCount + 1.

	activeContext := newContext.
	(self oop: newContext isLessThan: youngStart) ifTrue:
		[self beRootIfOld: newContext].
	self fetchContextRegisters: activeContext