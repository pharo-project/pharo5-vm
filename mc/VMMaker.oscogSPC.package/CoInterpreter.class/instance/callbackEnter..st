callback support
callbackEnter: callbackID
	"Re-enter the interpreter for executing a callback"
	| currentCStackPointer currentCFramePointer savedReenterInterpreter
	  wasInMachineCode calledFromMachineCode |
	<volatile>
	<export: true>
	<var: #currentCStackPointer type: #'void *'>
	<var: #currentCFramePointer type: #'void *'>
	<var: #callbackID type: #'sqInt *'>
	<var: #savedReenterInterpreter type: #'jmp_buf'>

	"For now, do not allow a callback unless we're in a primitiveResponse"
	(self asserta: primitiveFunctionPointer ~= 0) ifFalse:
		[^false].

	self assert: primFailCode = 0.

	"Check if we've exceeded the callback depth"
	(self asserta: jmpDepth < MaxJumpBuf) ifFalse:
		[^false].
	jmpDepth := jmpDepth + 1.

	wasInMachineCode := self isMachineCodeFrame: framePointer.
	calledFromMachineCode := instructionPointer <= objectMemory startOfMemory.

	"Suspend the currently active process"
	suspendedCallbacks at: jmpDepth put: self activeProcess.
	"We need to preserve newMethod explicitly since it is not activated yet
	and therefore no context has been created for it. If the caller primitive
	for any reason decides to fail we need to make sure we execute the correct
	method and not the one 'last used' in the call back"
	suspendedMethods at: jmpDepth put: newMethod.
	self flag: 'need to debug this properly.  Conceptually it is the right thing to do but it crashes in practice'.
	false
		ifTrue:
			["Signal external semaphores since a signalSemaphoreWithIndex: request may
			  have been issued immediately prior to this callback before the VM has any
			  chance to do a signalExternalSemaphores in checkForEventsMayContextSwitch:"
			 self signalExternalSemaphores.
			 "If no process is awakened by signalExternalSemaphores then transfer
			  to the highest priority runnable one."
			 (suspendedCallbacks at: jmpDepth) == self activeProcess ifTrue:
				[self transferTo: self wakeHighestPriority from: CSCallbackLeave]]
		ifFalse:
			[self transferTo: self wakeHighestPriority from: CSCallbackLeave].

	"Typically, invoking the callback means that some semaphore has been 
	signaled to indicate the callback. Force an interrupt check as soon as possible."
	self forceInterruptCheck.

	"Save the previous CStackPointers and interpreter entry jmp_buf."
	currentCStackPointer := cogit getCStackPointer.
	currentCFramePointer := cogit getCFramePointer.
	self mem: savedReenterInterpreter asVoidPointer
		cp: reenterInterpreter
		y: (self sizeof: #'jmp_buf').
	cogit assertCStackWellAligned.
	(self setjmp: (jmpBuf at: jmpDepth)) == 0 ifTrue: "Fill in callbackID"
		[callbackID at: 0 put: jmpDepth.
		 self enterSmalltalkExecutive.
		 self assert: false "NOTREACHED"].

	"Restore the previous CStackPointers and interpreter entry jmp_buf."
	cogit setCStackPointer: currentCStackPointer.
	cogit setCFramePointer: currentCFramePointer.
	self mem: reenterInterpreter
		cp: (self cCoerceSimple: savedReenterInterpreter to: #'void *')
		y: (self sizeof: #'jmp_buf').

	"Transfer back to the previous process so that caller can push result"
	self putToSleep: self activeProcess yieldingIf: preemptionYields.
	self transferTo: (suspendedCallbacks at: jmpDepth) from: CSCallbackLeave.
	newMethod := suspendedMethods at: jmpDepth.	"see comment above"
	argumentCount := self argumentCountOf: newMethod.
	self assert: wasInMachineCode = (self isMachineCodeFrame: framePointer).
	calledFromMachineCode
		ifTrue:
			[instructionPointer asUnsignedInteger >= objectMemory startOfMemory ifTrue:
				[self iframeSavedIP: framePointer put: instructionPointer.
				 instructionPointer := cogit ceReturnToInterpreterPC]]
		ifFalse:
			["Even if the context was flushed to the heap and rebuilt in transferTo:from:
			  above it will remain an interpreted frame because the context's pc would
			  remain a bytecode pc.  So the instructionPointer must also be a bytecode pc."
			 self assert: (self isMachineCodeFrame: framePointer) not.
			 self assert: instructionPointer > objectMemory startOfMemory].
	self assert: primFailCode = 0.
	jmpDepth := jmpDepth-1.
	^true