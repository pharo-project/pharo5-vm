callback support
callbackEnter: callbackID
	"Re-enter the interpreter for executing a callback"
	<export: true>
	<var: #callbackID type: #'sqInt *'>

	"For now, do not allow a callback unless we're in a primitiveResponse"
	(self asserta: primitiveFunctionPointer ~= 0) ifFalse:
		[^false].

	"Check if we've exceeded the callback depth"
	(self asserta: jmpDepth < MaxJumpBuf) ifFalse:
		[^false].
	jmpDepth := jmpDepth + 1.

	"Suspend the currently active process"
	suspendedCallbacks at: jmpDepth put: self activeProcess.
	"We need to preserve newMethod explicitly since it is not activated yet
	and therefore no context has been created for it. If the caller primitive
	for any reason decides to fail we need to make sure we execute the correct
	method and not the one 'last used' in the call back"
	suspendedMethods at: jmpDepth put: newMethod.
	"Signal external semaphores since a signalSemaphoreWithIndex: request may
	 have been issued immediately prior to this callback before the VM has any
	 chance to do a signalExternalSemaphores in checkForEventsMayContextSwitch:"
	self signalExternalSemaphores.
	"If no process is awakened by signalExternalSemaphores then transfer
	 to the highest priority runnable one."
	(suspendedCallbacks at: jmpDepth) == self activeProcess ifTrue:
		[self transferTo: self wakeHighestPriority].

	"Typically, invoking the callback means that some semaphore has been 
	signaled to indicate the callback. Force an interrupt check as soon as possible."
	self forceInterruptCheck.

	(self setjmp: (jmpBuf at: jmpDepth)) == 0 ifTrue: "Fill in callbackID"
		[callbackID at: 0 put: jmpDepth.
		self interpret].

	"Transfer back to the previous process so that caller can push result"
	self putToSleep: self activeProcess yieldingIf: preemptionYields.
	self transferTo: (suspendedCallbacks at: jmpDepth).
	newMethod := suspendedMethods at: jmpDepth.	"see comment above"
	argumentCount := self argumentCountOf: newMethod.
	jmpDepth := jmpDepth-1.
	"clean out the primPops etc since we'll be returning via primitive"
	self initPrimCall.
	^true