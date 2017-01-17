process primitives
primitiveExitCriticalSection
	"Exit the critical section.
	 This may change the active process as a result."
	| criticalSection owningProcessIndex inInterpreter owningProcess |
	criticalSection := self stackTop.  "rcvr"
	owningProcessIndex := ExcessSignalsIndex. "CriticalSections are laid out like Semaphores"
	(self isEmptyList: criticalSection)
		ifTrue:
			[objectMemory storePointerUnchecked: owningProcessIndex
				ofObject: criticalSection
				withValue: objectMemory nilObject]
		ifFalse:
			["We're going to switch process, either to an interpreted frame or a machine
			  code frame. To know whether to return or enter machine code we have to
			  know from whence we came.  We could have come from the interpreter,
			  either directly or via a machine code primitive.  We could have come from
			  machine code.  The instructionPointer tells us where from:"
			 inInterpreter := instructionPointer >= objectMemory startOfMemory.
			 owningProcess := self removeFirstLinkOfList: criticalSection.
			 "store check unnecessary because aSemaphore referred to owningProcess
			  via its FirstLinkIndex slot before owningProcess was removed."
			 objectMemory storePointerUnchecked: owningProcessIndex
				ofObject: criticalSection
				withValue: owningProcess.
			 "Note that resume: isn't fair; it won't suspend the active process.
			  For fairness we must do the equivalent of a primitiveYield, but that
			  may break old code, so we stick with unfair resume:."
			 (self resume: owningProcess
				preemptedYieldingIf: preemptionYields
				from: CSExitCriticalSection) ifTrue:
						[self forProcessPrimitiveReturnToExecutivePostContextSwitch: inInterpreter]]