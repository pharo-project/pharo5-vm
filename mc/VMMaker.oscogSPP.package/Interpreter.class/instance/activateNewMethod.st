message sending
activateNewMethod
	| newContext methodHeader initialIP tempCount nilOop where |

	methodHeader := self methodHeaderOf: newMethod.
	newContext := self allocateOrRecycleContext: (methodHeader bitAnd: LargeContextBit).

	initialIP := ((LiteralStart + (self literalCountOfMethodHeader: methodHeader)) * self wordSize) + 1.
	tempCount := (methodHeader >> 19) bitAnd: 16r3F.

	"Assume: newContext will be recorded as a root if necessary by the
	 call to newActiveContext: below, so we can use unchecked stores."

	where :=  newContext  + self baseHeaderSize.
	self longAt: where + (SenderIndex << self shiftForWord) put: activeContext.
	self longAt: where + (InstructionPointerIndex << self shiftForWord) put: (self integerObjectOf: initialIP).
	self longAt: where + (StackPointerIndex << self shiftForWord) put: (self integerObjectOf: tempCount).
	self longAt: where + (MethodIndex << self shiftForWord) put: newMethod.
	self longAt: where + (ClosureIndex << self shiftForWord) put: nilObj.

	"Copy the receiver and arguments..."
	0 to: argumentCount do:
		[:i | self longAt: where + ((ReceiverIndex+i) << self shiftForWord) put: (self stackValue: argumentCount-i)].

	"clear remaining temps to nil in case it has been recycled"
	nilOop := nilObj.
	argumentCount+1+ReceiverIndex to: tempCount+ReceiverIndex do:
		[:i | self longAt: where + (i << self shiftForWord) put: nilOop].

	self pop: argumentCount + 1.
	reclaimableContextCount := reclaimableContextCount + 1.
	self newActiveContext: newContext.