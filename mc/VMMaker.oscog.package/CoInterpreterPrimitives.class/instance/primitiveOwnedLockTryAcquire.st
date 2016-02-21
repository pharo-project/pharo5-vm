process primitives
primitiveOwnedLockTryAcquire
	"Non-blocking attempt to acquire an OwnedLock. 
	 * 	If not owned, set the owner to the current process and answer TRUE, 
		since the lock is acquired here.
	 * If owned by another process answer FALSE, 
	   since the lock could not be aquired.
	 * If already owned by current process, answer NIL, 
	   since lock is reused rather than aquired here.	
	 * 	An argument indicates simulation, which is taken to be the effective activeProcess
	   (see Process>>effectiveProcess).
	 * Based on primitiveTestAndSetOwnershipOfCriticalSection with modified semantics
		of return value."

	| ownedLock owningProcessIndex owningProcess activeProc |
	self printStringOf: 'BLAH2' ; flush.
	argumentCount > 0
		ifTrue:
			[ownedLock := self stackValue: 1.  "rcvr"
			 activeProc := self stackTop]
		ifFalse:
			[ownedLock := self stackTop.  "rcvr"
			 activeProc := self activeProcess].
	owningProcessIndex := ExcessSignalsIndex. "OwnedLocks are laid out like Semaphores"
	owningProcess := objectMemory fetchPointer: owningProcessIndex ofObject: ownedLock.

	owningProcess = objectMemory nilObject ifTrue: 
		[objectMemory storePointer: owningProcessIndex
			ofObject: ownedLock
			withValue: activeProc.
		 ^self pop: argumentCount + 1 thenPush: objectMemory trueObject]."unowned, acquired"
	owningProcess = activeProc ifTrue: 
		[^self pop: argumentCount + 1 thenPush: objectMemory nilObject]. "already owned, reused"
	self pop: argumentCount + 1 thenPush: objectMemory falseObject. "not owned"