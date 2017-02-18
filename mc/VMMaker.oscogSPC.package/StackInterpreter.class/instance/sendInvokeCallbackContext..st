callback support
sendInvokeCallbackContext: vmCallbackContext
	"Send the calllback message to Alien class with the supplied arg(s).  Use either the
	 1 arg invokeCallbackContext: or the 4 arg invokeCallback:stack:registers:jmpbuf:
	 message, depending on what selector is installed in the specialObjectsArray.
	 Note that if invoking the legacy invokeCallback:stack:registers:jmpbuf: we pass the
	 vmCallbackContext as the jmpbuf argument (see reestablishContextPriorToCallback:).
	 The arguments are raw C addresses and are converted to integer objects on the way."
	<export: true>
	<var: #vmCallbackContext type: #'VMCallbackContext *'>
	| classTag |
	classTag := self fetchClassTagOfNonImm: (self splObj: ClassAlien).
	messageSelector := self splObj: SelectorInvokeCallback.
	(self lookupInMethodCacheSel: messageSelector classTag: classTag) ifFalse:
	 	[(self lookupOrdinaryNoMNUEtcInClass: (objectMemory classForClassTag: classTag)) ~= 0 ifTrue:
			[^false]].
	primitiveFunctionPointer ~= 0 ifTrue:
		[^false].
	self saveCStackStateForCallbackContext: vmCallbackContext.
	self push: (self splObj: ClassAlien). "receiver"
	(self argumentCountOf: newMethod) = 4 ifTrue:
		[self push: (self positiveMachineIntegerFor: vmCallbackContext thunkp asUnsignedInteger).
		 self push: (self positiveMachineIntegerFor: vmCallbackContext stackp asUnsignedInteger).
		 self push: (self positiveMachineIntegerFor: vmCallbackContext intregargsp asUnsignedInteger)].
	self push: (self positiveMachineIntegerFor: vmCallbackContext asUnsignedInteger).
	self ifAppropriateCompileToNativeCode: newMethod selector: messageSelector.
	self justActivateNewMethod.
	(self isMachineCodeFrame: framePointer) ifFalse:
		[self maybeFlagMethodAsInterpreted: newMethod].
	self externalWriteBackHeadFramePointers.
	self checkForStackOverflow.
	self enterSmalltalkExecutiveFromCallback.
	"not reached"
	^true