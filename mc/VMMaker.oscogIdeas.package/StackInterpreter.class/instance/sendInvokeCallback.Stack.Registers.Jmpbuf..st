callback support
sendInvokeCallback: thunkPtr Stack: stackPtr Registers: regsPtr Jmpbuf: jmpBufPtr
	"Send the 4 argument callback message invokeCallback:stack:registers:jmpbuf:
	 to Alien class with the supplied args.  The arguments are raw C addresses
	 and are converted to integer objects on the way."
	<export: true>
	| classTag |
	classTag := self fetchClassTagOfNonImm: (self splObj: ClassAlien).
	messageSelector := self splObj: SelectorInvokeCallback.
	argumentCount := 4.
	(self lookupInMethodCacheSel: messageSelector classTag: classTag) ifFalse:
	 	[(self lookupOrdinaryNoMNUEtcInClass: (objectMemory classForClassTag: classTag)) ~= 0 ifTrue:
			[^false]].
	((self argumentCountOf: newMethod) = 4
	and: [primitiveFunctionPointer = 0]) ifFalse:
		[^false].
	self push: (self splObj: ClassAlien). "receiver"
	self push: (self positiveMachineIntegerFor: thunkPtr).
	self push: (self positiveMachineIntegerFor: stackPtr).
	self push: (self positiveMachineIntegerFor: regsPtr).
	self push: (self positiveMachineIntegerFor: jmpBufPtr).
	self ifAppropriateCompileToNativeCode: newMethod selector: messageSelector.
	self justActivateNewMethod.
	(self isMachineCodeFrame: framePointer) ifFalse:
		[self maybeFlagMethodAsInterpreted: newMethod].
	self checkForStackOverflow.
	self enterSmalltalkExecutiveFromCallback.
	"not reached"
	^true