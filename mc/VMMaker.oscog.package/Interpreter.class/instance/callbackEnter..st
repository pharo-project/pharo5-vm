callback support
callbackEnter: callbackID
	"Re-enter the interpreter for executing a callback"
	| result activeProc |
	<export: true>
	<var: #callbackID declareC: 'sqInt *callbackID'>

	"For now, do not allow a callback unless we're in a primitiveResponse"
	primitiveIndex = 0 ifTrue:[^false].

	"Check if we've exceeded the callback depth"
	jmpDepth >= jmpMax ifTrue:[^false].
	jmpDepth := jmpDepth + 1.

	"Suspend the currently active process"
	activeProc := self fetchPointer: ActiveProcessIndex
						 ofObject: self schedulerPointer.
	suspendedCallbacks at: jmpDepth put: activeProc.
	"We need to preserve newMethod explicitly since it is not activated yet
	and therefore no context has been created for it. If the caller primitive
	for any reason decides to fail we need to make sure we execute the correct
	method and not the one 'last used' in the call back"
	suspendedMethods at: jmpDepth put: newMethod.
	self transferTo: self wakeHighestPriority.

	"Typically, invoking the callback means that some semaphore has been 
	signaled to indicate the callback. Force an interrupt check right away."
	self forceInterruptCheck.

	result := self setjmp: (jmpBuf at: jmpDepth).
	result == 0 ifTrue:["Fill in callbackID"
		callbackID at: 0 put: jmpDepth.
		"This is ugly but the inliner treats interpret() in very special and strange ways and calling any kind of 'self interpret' either directly or even via cCode:inSmalltalk: will cause this entire method to vanish."
		self cCode: 'interpret()'.
	].

	"Transfer back to the previous process so that caller can push result"
	activeProc := self fetchPointer: ActiveProcessIndex
						 ofObject: self schedulerPointer.
	self putToSleep: activeProc.
	activeProc := suspendedCallbacks at: jmpDepth.
	newMethod := suspendedMethods at: jmpDepth.	"see comment above"
	self transferTo: activeProc.
	jmpDepth := jmpDepth-1.
	^true