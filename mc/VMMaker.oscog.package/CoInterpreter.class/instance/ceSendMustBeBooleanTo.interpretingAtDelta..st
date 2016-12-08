trampolines
ceSendMustBeBooleanTo: anObject interpretingAtDelta: jumpSize
	"For RegisterAllocatingCogit we want the address following a conditional branch not to be reachable, so we
	 don't have to generate code to reload registers.  Instead simply convert to an interpreter frame."
	<api>
	self flag: 'A nice way to implement this is to
		- provide an additional argument that is the size of the branch (have trampolines for 1 & 2 byte jumps).
		  Note that there is no need to back up before any extensions since the branch will not be taken.
			ceSendMustBeBooleanTo: anObject interpretingAtDelta: jumpSize
		- map the frame to an interpreter frame
		- push anObject
		- back up the pc to position the interpreter at the jump
		- enter the interpreter, hence reexecuting the mustBeBoolean'.
	self shouldBeImplemented.
	instructionPointer := self popStack.
	self push: anObject.
	self push: instructionPointer.
	^self
		ceSendAbort: (objectMemory splObj: SelectorMustBeBoolean)
		to: anObject
		numArgs: 0