I/O primitives
primitiveRelinquishProcessor
	"Relinquish the processor for up to the given number of microseconds.
	 The exact behavior of this primitive is platform dependent.
	 Override to check for waiting threads."

	| microSecs threadIndexAndFlags currentCStackPointer currentCFramePointer savedReenterInterpreter |
	<var: #currentCStackPointer type: #'void *'>
	<var: #currentCFramePointer type: #'void *'>
	<var: #savedReenterInterpreter type: #'jmp_buf'>
	microSecs := self stackTop.
	(objectMemory isIntegerObject: microSecs) ifFalse:
		[^self primitiveFail].
	self assert: (objectMemory fetchPointer: MyListIndex ofObject: self activeProcess) = objectMemory nilObject.
	self assert: relinquishing not.
	"DO NOT allow relinquishing the processor while we are profiling since this
	 may skew the time base for our measures (it may reduce processor speed etc).
	 Instead we go full speed, therefore measuring the precise time we spend in the
	 inner idle loop as a busy loop."
	nextProfileTick = 0 ifTrue:
		"Presumably we have nothing to do; this primitive is typically called from the
		 background process. So we should /not/ try and activate any threads in the
		 pool; they will waste cycles finding there is no runnable process, and will
		 cause a VM abort if no runnable process is found.  But we /do/ want to allow
		 FFI calls that have completed, or callbacks a chance to get into the VM; they
		 do have something to do.  DisownVMForProcessorRelinquish indicates this."
		[currentCStackPointer := cogit getCStackPointer.
		 currentCFramePointer := cogit getCFramePointer.
		 self cCode:
			[self mem: savedReenterInterpreter asVoidPointer
				cp: reenterInterpreter
				y: (self sizeof: #'jmp_buf')].
		 threadIndexAndFlags := self disownVM: DisownVMForProcessorRelinquish.
		 self assert: relinquishing.
		 self ioRelinquishProcessorForMicroseconds: (objectMemory integerValueOf: microSecs).
		 self assert: relinquishing.
		 self ownVM: threadIndexAndFlags.
		 self assert: relinquishing not.
		 self assert: cogThreadManager currentVMThread state = CTMAssignableOrInVM.
		 self assert: currentCStackPointer = cogit getCStackPointer.
		 self assert: currentCFramePointer = cogit getCFramePointer.
		 self cCode:
			[self assert: (self mem: (self cCoerceSimple: savedReenterInterpreter to: #'void *')
						cm: reenterInterpreter
						p: (self sizeof: #'jmp_buf')) = 0]].
	self assert: (objectMemory fetchPointer: MyListIndex ofObject: self activeProcess) = objectMemory nilObject.
	self pop: 1  "microSecs; leave rcvr on stack"