callback support
sendInvokeCallbackContext: vmCallbackContext
	"Send the calllback message to Alien class with the supplied arg(s).  Use either the 1 arg
	 invokeCallbackContext: or the 4 arg invokeCallback:stack:registers:jmpbuf: message,
	 depending on what selector is installed in the specialObjectsArray. Note that if invoking the
	 legacy invokeCallback:stack:registers:jmpbuf: we pass the vmCallbackContext as the jmpbuf
	 argument (see reestablishContextPriorToCallback:). The arguments are raw C addresses and
	 are converted to integer objects on the way. sendInvokeCallbackContext: &
	 returnAs:ThroughCallback:Context: along with ownVM: and disownVM: conspire to save and
	 restore newMethod, argumentCount and primitiveFunctionPointer around a callback.
	 The VM depends on argumentCount being correct to cut-back the correct number of
	 arguments on primitive return.  If a primitive that invokes a callback fails after invoking a
	 callback (a bad idea, but s**t happens during development) then newMethod is required to
	 activate the right faling method, and Spur expects primitiveFunctionPointer to be valid, so
	 asserts will fail misleadingly if not."
	<export: true>
	<var: #vmCallbackContext type: #'VMCallbackContext *'>
	| classTag |
	vmCallbackContext savedPrimFunctionPointer: primitiveFunctionPointer.
	classTag := self fetchClassTagOfNonImm: (objectMemory splObj: ClassAlien).
	messageSelector := self splObj: SelectorInvokeCallback.
	(self lookupInMethodCacheSel: messageSelector classTag: classTag) ifFalse:
	 	[(self lookupOrdinaryNoMNUEtcInClass: (objectMemory classForClassTag: classTag)) ~= 0 ifTrue:
			[^false]].
	primitiveFunctionPointer ~= 0 ifTrue:
		[primitiveFunctionPointer := vmCallbackContext savedPrimFunctionPointer.
		 ^false].
	self assert: (debugCallbackInvokes := debugCallbackInvokes + 1) > 0.
	"self assert: debugCallbackInvokes < 3802."
	self saveCStackStateForCallbackContext: vmCallbackContext.
	self push: (objectMemory splObj: ClassAlien). "receiver"
	(self argumentCountOf: newMethod) = 4 ifTrue:
		[self push: (self positiveMachineIntegerFor: vmCallbackContext thunkp asUnsignedInteger).
		 self push: (self positiveMachineIntegerFor: vmCallbackContext stackp asUnsignedInteger).
		 self push: (self positiveMachineIntegerFor: vmCallbackContext intregargsp asUnsignedInteger)].
	self push: (self positiveMachineIntegerFor: vmCallbackContext asUnsignedInteger).
	self ifAppropriateCompileToNativeCode: newMethod selector: messageSelector.
	self justActivateNewMethod.
	(self isMachineCodeFrame: framePointer) ifFalse:
		[self maybeFlagMethodAsInterpreted: newMethod].
	self checkForStackOverflow.
	self assert: (self frameReceiver: framePointer) = (objectMemory splObj: ClassAlien).
	self enterSmalltalkExecutiveFromCallback.
	"not reached"
	^true