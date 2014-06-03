callback support
returnAs: returnTypeOop ThroughCallback: vmCallbackContext Context: callbackMethodContext
	"callbackMethodContext is an activation of invokeCallback:[stack:registers:jmpbuf:].
	 Its sender is the VM's state prior to the callback.  Reestablish that state (via longjmp),
	 and mark callbackMethodContext as dead."
	<export: true>
	<var: #vmCallbackContext type: #'VMCallbackContext *'>
	| calloutMethodContext |
	((self isIntegerObject: returnTypeOop)
	 and: [self isContext: callbackMethodContext]) ifFalse:
		[^false].
	calloutMethodContext := self fetchPointer: SenderIndex ofObject: callbackMethodContext.
	(self isContext: calloutMethodContext) ifFalse:
		[^false].
	self newActiveContext: calloutMethodContext.
	 "N.B. siglongjmp is defines as _longjmp on non-win32 platforms.
	  This matches the use of _setjmp in ia32abicc.c."
	self siglong: vmCallbackContext trampoline jmp: (self integerValueOf: returnTypeOop).
	"NOTREACHED"
	^true