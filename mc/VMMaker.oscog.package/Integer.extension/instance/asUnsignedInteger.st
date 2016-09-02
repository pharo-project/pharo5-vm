*VMMaker-interpreter simulator
asUnsignedInteger
	"Since the simulator deals with positive integers most of the time we assert that the receiver is greater than zero.
	 But one major exception is stack pointers in the StackInterpreterSimulator, which are negative.  So don't fail
	 if the sender is a StackInterpreter and the receiver could be a stack pointer."
	self >= 0 ifFalse:
		[self assert: (((thisContext sender methodClass includesBehavior: CoInterpreter)
					   and: [self between: Cogit maxNegativeErrorCode and: -1])
					or: [(thisContext sender methodClass includesBehavior: StackInterpreter)
					   and: [thisContext sender receiver stackPages couldBeFramePointer: self]])].
	^self