enilopmarts
ensurePushedInstructionPointer
	"We're about to make some transition to a machine code method which
	 requires the instructionPointer must be on the stack.  We could have come
	 from the interpreter, either directly or via a machine code primitive.  We
	 could have come from machine code.  The instructionPointer tells us where
	 from.  Make sure the instruction pointer is pushed and/or saved."
	instructionPointer asUnsignedInteger >= objectMemory startOfMemory
		ifTrue:
			"invoked directly from the interpreter"
			[self iframeSavedIP: framePointer put: instructionPointer.
			 self push: cogit ceReturnToInterpreterPC]
		ifFalse:
			["instructionPointer == cogit ceReturnToInterpreterPC
				ifTrue: [invoked from the interpreter via a machine code primitive]
				ifFalse: [invoked from machine code].
			 If in the first case the bytecode instructionPointer has already been
			 saved in iframeSavedIP so all we need to do is push the instructionPointer."
			 self push: instructionPointer]