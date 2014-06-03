process primitives
primitiveEnterCriticalSection
	"Attempt to enter a CriticalSection/Mutex.  If not owned, set the owner to the current
	 process and answer false. If owned by the current process  answer true.   Otherwise
	 suspend the process.  Answer if the receiver is owned by the current process."
	| criticalSection owningProcessIndex owningProcess activeProc inInterpreter |
	argumentCount > 0
		ifTrue:
			[criticalSection := self stackValue: 1.  "rcvr"
			 activeProc := self stackTop]
		ifFalse:
			[criticalSection := self stackTop.  "rcvr"
			 activeProc := self activeProcess].
	owningProcessIndex := ExcessSignalsIndex. "CriticalSections are laid out like Semaphores"
	owningProcess := objectMemory fetchPointer: owningProcessIndex ofObject: criticalSection.
	owningProcess = objectMemory nilObject ifTrue:
		[objectMemory storePointer: owningProcessIndex
			ofObject: criticalSection
			withValue: activeProc.
		 ^self pop: argumentCount + 1 thenPush: objectMemory falseObject].
	owningProcess = activeProc ifTrue:
		[^self pop: argumentCount + 1 thenPush: objectMemory trueObject].
	"Arrange to answer false (unowned) when the process is resumed."
	self pop: argumentCount + 1 thenPush: objectMemory falseObject.
	"We're going to switch process, either to an interpreted frame or a machine
	 code frame. To know whether to return or enter machine code we have to
	 know from whence we came.  We could have come from the interpreter,
	 either directly or via a machine code primitive.  We could have come from
	 machine code.  The instructionPointer tells us where from:"
	inInterpreter := instructionPointer >= objectMemory startOfMemory.
	self addLastLink: activeProc toList: criticalSection.
	self transferTo: self wakeHighestPriority from: CSEnterCriticalSection.
	self forProcessPrimitiveReturnToExecutivePostContextSwitch: inInterpreter