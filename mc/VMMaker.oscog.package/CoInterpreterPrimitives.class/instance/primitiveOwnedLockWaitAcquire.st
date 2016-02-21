process primitives
primitiveOwnedLockWaitAcquire
	"Blocking attempt to acquire an OwnedLock. 
	 * 	If not owned, set the owner to the current process and answer TRUE, 
		since the lock is acquired here.
	 * If owned by another process, suspend current process such that TRUE
	   is answered when it is resumed by primitiveOwnedLockRelease, 
	   since effectively that is when the lock is aquired by the current process.
	 * If already owned by current process answer NIL, 
	   since lock is reused rather than aquired here.			
	 * 	An argument indicates simulation, which is taken to be the effective activeProcess
	   (see Process>>effectiveProcess).
	 * Based on primitiveEnterCriticalSection with modified semantics
		of return value."
		
	| ownedLock owningProcessIndex owningProcess activeProc inInterpreter |
	self printStringOf: 'BLAH3' ; flush.
	argumentCount > 0
		ifTrue:
			[ownedLock := self stackValue: 1.  "rcvr"
			 activeProc := self stackTop]
		ifFalse:
			[ownedLock := self stackTop.  "rcvr"
			 activeProc := self activeProcess].
	owningProcessIndex := ExcessSignalsIndex. "CriticalSections are laid out like Semaphores"
	owningProcess := objectMemory fetchPointer: owningProcessIndex ofObject: ownedLock.
	owningProcess = objectMemory nilObject ifTrue:
		[objectMemory storePointer: owningProcessIndex
			ofObject: ownedLock
			withValue: activeProc.
		 ^self pop: argumentCount + 1 thenPush: objectMemory trueObject]. "unowned, acquired"
	owningProcess = activeProc ifTrue:
		[^self pop: argumentCount + 1 thenPush: objectMemory nilObject]. "already owned, reused"
	"Lock is owned by someone else. Go to sleep after arranging to answer true when 
	 the release primitive aquires it for us and wakes us up." 
	self pop: argumentCount + 1 thenPush: objectMemory trueObject. "acquired after sleeping"
	"We're going to switch process, either to an interpreted frame or a machine
	 code frame. To know whether to return or enter machine code we have to
	 know from whence we came.  We could have come from the interpreter,
	 either directly or via a machine code primitive.  We could have come from
	 machine code.  The instructionPointer tells us where from:"
	inInterpreter := instructionPointer >= objectMemory startOfMemory.
	self addLastLink: activeProc toList: ownedLock.
	self transferTo: self wakeHighestPriority from: CSEnterCriticalSection.
	self forProcessPrimitiveReturnToExecutivePostContextSwitch: inInterpreter