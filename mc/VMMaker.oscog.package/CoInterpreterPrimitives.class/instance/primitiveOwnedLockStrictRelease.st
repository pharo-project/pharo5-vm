process primitives
primitiveOwnedLockStrictRelease
	"Release of lock by the *owner*  
	 * Fail if a non-owner tries to release the lock.
	 * 	An argument indicates simulation, which is taken to be the effective activeProcess
	   This mechanism can be used by a non-owner to force/break the lock. 
	 * Active process may be changed as a result.
	 * Based on primitiveExitCriticalSection, but modified to be strict.
		For a non-strict release, the image can either
		* pass the owner as the argument
		* invoke original primitiveExitCriticalSection 
		"
	| ownedLock activeProcess owningProcessIndex inInterpreter owningProcess |
	argumentCount > 0
		ifTrue:
			[ownedLock := self stackValue: 1.  "rcvr"
			 activeProcess := self stackTop]
		ifFalse:
			[ownedLock := self stackTop.  "rcvr"
			 activeProcess := self activeProcess].
	owningProcessIndex := ExcessSignalsIndex. "CriticalSections are laid out like Semaphores"
	owningProcess := objectMemory fetchPointer: owningProcessIndex ofObject: ownedLock.

	"Check activeProcess is owner"
	owningProcess = activeProcess ifFalse: [self primitiveFail].
	
	(self isEmptyList: ownedLock)
		ifTrue:
			[objectMemory storePointerUnchecked: owningProcessIndex
				ofObject: ownedLock
				withValue: objectMemory nilObject]
		ifFalse:
			["We're going to switch process, either to an interpreted frame or a machine
			  code frame. To know whether to return or enter machine code we have to
			  know from whence we came.  We could have come from the interpreter,
			  either directly or via a machine code primitive.  We could have come from
			  machine code.  The instructionPointer tells us where from:"
			 inInterpreter := instructionPointer >= objectMemory startOfMemory.
			 owningProcess := self removeFirstLinkOfList: ownedLock.
			 "store check unnecessary because aSemaphore referred to owningProcess
			  via its FirstLinkIndex slot before owningProcess was removed."
			 objectMemory storePointerUnchecked: owningProcessIndex
				ofObject: ownedLock
				withValue: owningProcess.
			 "Note that resume: isn't fair; it won't suspend the active process.
			  For fairness we must do the equivalent of a primitiveYield, but that
			  may break old code, so we stick with unfair resume:."
			 (self resume: owningProcess
				preemptedYieldingIf: preemptionYields
				from: CSExitCriticalSection) ifTrue:
						[self forProcessPrimitiveReturnToExecutivePostContextSwitch: inInterpreter]]