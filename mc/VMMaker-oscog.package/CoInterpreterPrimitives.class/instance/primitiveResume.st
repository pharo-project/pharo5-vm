process primitives
primitiveResume
	"Put this process on the scheduler's lists thus allowing it to proceed next time there is
	 a chance for processes of it's priority level.  It must go to the back of its run queue so
	 as not to preempt any already running processes at this level.  If the process's priority
	 is higher than the current process, preempt the current process."
	| proc inInterpreter |
	proc := self stackTop.  "rcvr"
	(objectMemory isContext: (objectMemory fetchPointer: SuspendedContextIndex ofObject: proc)) ifFalse:
		[^self primitiveFail].
	"We're about to switch process, either to an interpreted frame or a
	 machine code frame. To know whether to return or enter machine code
	 we have to know from whence we came.  We could have come from the
	 interpreter, either directly or via a machine code primitive.  We could have
	 come from machine code.  The instructionPointer tells us where from:"
	inInterpreter := instructionPointer >= objectMemory startOfMemory.
	(self resume: proc preemptedYieldingIf: preemptionYields from: CSResume) ifTrue:
		[self forProcessPrimitiveReturnToExecutivePostContextSwitch: inInterpreter]

	"Personally I would like to check MyList, which should not be one of the elements of the scheduler lists.
	 But there are awful race conditions in things like should:notTakeMoreThan: that mean we can't.
	 eem 9/27/2010 23:08. e.g.

	| proc myList classLinkedList |
	proc := self stackTop.
	myList := objectMemory fetchPointer: MyListIndex ofObject: proc.
	classLinkedList := self superclassOf: (objectMemory splObj: ClassSemaphore).
	((self fetchClassOfNonInt: myList) ~= classLinkedList
	and: [objectMemory isContext: (objectMemory fetchPointer: SuspendedContextIndex ofObject: proc)]) ifFalse:
		[^self primitiveFail].
	''We're about to switch process, either to an interpreted frame or a
	 machine code frame. To know whether to return or enter machine code
	 we have to know from whence we came.  We could have come from the
	 interpreter, either directly or via a machine code primitive.  We could have
	 come from machine code.  The instructionPointer tells us where from:''
	inInterpreter := instructionPointer >= objectMemory startOfMemory.
	(self resume: proc  preemptedYieldingIf: preemptionYields from: CSResume) ifTrue:
		[self forProcessPrimitiveReturnToExecutivePostContextSwitch: inInterpreter]"