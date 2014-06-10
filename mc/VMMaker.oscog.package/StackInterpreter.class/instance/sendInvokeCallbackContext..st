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
	 	[(self lookupMethodNoMNUEtcInClass: (objectMemory classForClassTag: classTag)) ~= 0 ifTrue:
			[^false]].
	primitiveFunctionPointer ~= 0 ifTrue:
		[^false].
	self saveCStackStateForCallbackContext: vmCallbackContext.
	self push: (self splObj: ClassAlien). "receiver"
	self cppIf: BytesPerWord = 8
		ifTrue:
			[(self argumentCountOf: newMethod) = 4 ifTrue:
				[self push: (self positive64BitIntegerFor: vmCallbackContext thunkp asUnsignedInteger).
				 self push: (self positive64BitIntegerFor: vmCallbackContext stackp asUnsignedInteger).
				 self push: (self positive64BitIntegerFor: vmCallbackContext intregargsp asUnsignedInteger)].
			 self push: (self positive64BitIntegerFor: vmCallbackContext asUnsignedInteger)]
		ifFalse:
			[(self argumentCountOf: newMethod) = 4 ifTrue:
				[self push: (self positive32BitIntegerFor: vmCallbackContext thunkp asUnsignedInteger).
				 self push: (self positive32BitIntegerFor: vmCallbackContext stackp asUnsignedInteger).
				 self push: (self positive32BitIntegerFor: vmCallbackContext intregargsp asUnsignedInteger)].
			 self push: (self positive32BitIntegerFor: vmCallbackContext asUnsignedInteger)].
	self ifAppropriateCompileToNativeCode: newMethod selector: messageSelector.
	self justActivateNewMethod.
	(self isMachineCodeFrame: framePointer) ifFalse:
		[self maybeFlagMethodAsInterpreted: newMethod].
	self externalWriteBackHeadFramePointers.
	self handleStackOverflow.
	self enterSmalltalkExecutiveFromCallback.
	"not reached"
	^true