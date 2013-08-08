process primitives
primitiveTestAndSetOwnershipOfCriticalSection
	"Attempt to test-and-set the ownership of the critical section.  If not owned,
	 set the owner to the current process and answer false. If owned by the
	 current process answer true.  If owned by some other process answer nil.
	 For simulation if there is an argument it is taken to be the effective activeProcess
	 (see Process>>effectiveProcess)."
	| criticalSection owningProcessIndex owningProcess activeProc |
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
	self pop: argumentCount + 1 thenPush: objectMemory nilObject