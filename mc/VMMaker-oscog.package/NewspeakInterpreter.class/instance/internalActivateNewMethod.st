message sending
internalActivateNewMethod
	| methodHeader initialIP newContext tempCount argCount2 needsLarge where |
	<inline: true>

	methodHeader := self headerOf: newMethod.
	needsLarge := methodHeader bitAnd: LargeContextBit.
	(needsLarge = 0 and: [freeContexts ~= NilContext])
		ifTrue: [newContext := freeContexts.
				freeContexts := self fetchPointer: 0 ofObject: newContext]
		ifFalse: ["Slower call for large contexts or empty free list"
				self externalizeIPandSP.
				newContext := self allocateOrRecycleContext: needsLarge.
				self internalizeIPandSP].
	initialIP := ((LiteralStart + (self literalCountOfHeader: methodHeader)) * BytesPerWord) + 1.
	tempCount := (methodHeader >> 19) bitAnd: 16r3F.

	"Assume: newContext will be recorded as a root if necessary by the
	 call to newActiveContext: below, so we can use unchecked stores."
	where :=   newContext + BaseHeaderSize.
	self longAt: where + (SenderIndex << ShiftForWord) put: activeContext.
	self longAt: where + (InstructionPointerIndex << ShiftForWord) put: (self integerObjectOf: initialIP).
	self longAt: where + (StackPointerIndex << ShiftForWord) put: (self integerObjectOf: tempCount).
	self longAt: where + (MethodIndex << ShiftForWord) put: newMethod.
	self longAt: where + (ClosureIndex << ShiftForWord) put: nilObj.

	"Copy the receiver and arguments..."
	argCount2 := argumentCount.
	0 to: argCount2 do:
		[:i | self longAt: where + ((ReceiverIndex+i) << ShiftForWord) put: (self internalStackValue: argCount2-i)].

	"clear remaining temps to nil in case it has been recycled"
	needsLarge := nilObj.  "needsLarge here used just as faster (register?) temp"
	argCount2+1+ReceiverIndex to: tempCount+ReceiverIndex do:
		[:i | self longAt: where + (i << ShiftForWord) put: needsLarge].

	"Pass primitive error code to last temp if method receives it (indicated
	 by an initial long store temp bytecode).  Protect against obsolete values
	 in primFailCode by checking that newMethod actually has a primitive?"
	primFailCode > 0 ifTrue:
		[((self primitiveIndexOfMethodHeader: methodHeader) > 0
		  and: [(self fetchByte: initialIP - 1 ofObject: newMethod) = 129 "long store temp"]) ifTrue:
			[needsLarge := self fetchPointer: primFailCode - 1 ofObject: (self splObj: PrimErrTableIndex).
			 self longAt: where + ((tempCount+ReceiverIndex) << ShiftForWord)
				put: needsLarge "nil if primFailCode == 1, or primFailCode"].
		primFailCode := 0].

	self internalPop: argCount2 + 1.
	reclaimableContextCount := reclaimableContextCount + 1.
	self internalNewActiveContext: newContext.
 