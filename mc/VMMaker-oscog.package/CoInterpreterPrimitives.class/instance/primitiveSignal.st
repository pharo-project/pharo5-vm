process primitives
primitiveSignal
	"Synchronously signal the semaphore.
	 This may change the active process as a result."
	| inInterpreter |
	"We may be about to switch process, either to an interpreted frame or a
	 machine code frame. To know whether to return or enter machine code
	 we have to know from whence we came.  We could have come from the
	 interpreter, either directly or via a machine code primitive.  We could have
	 come from machine code.  The instructionPointer tells us where from:"
	inInterpreter := instructionPointer >= objectMemory startOfMemory.
	(self synchronousSignal: self stackTop) ifTrue:
		[self forProcessPrimitiveReturnToExecutivePostContextSwitch: inInterpreter]