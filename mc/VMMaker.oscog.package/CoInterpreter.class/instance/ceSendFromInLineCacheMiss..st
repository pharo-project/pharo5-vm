trampolines
ceSendFromInLineCacheMiss: cogMethodOrPIC
	"Send from an Open PIC when the first-level method lookup probe has failed,
	 or to continue when PIC creation has failed (e.g. because we're out of code space),
	 or when a send has failed due to a forwarded receiver."
	<api>
	<var: #cogMethodOrPIC type: #'CogMethod *'>
	| numArgs rcvr classTag classObj errSelIdx |
	"self printFrame: stackPage headFP WithSP: stackPage headSP"
	"self printStringOf: selector"
	numArgs := cogMethodOrPIC cmNumArgs.
	rcvr := self stackValue: numArgs + 1. "skip return pc"
	self assert: (objectMemory addressCouldBeOop: rcvr).
	classTag := objectMemory fetchClassTagOf: rcvr.
	argumentCount := numArgs.
	false ifTrue: "would like to assert this but must also allow for an interpretable method in the cache."
		[self deny: (cogMethodOrPIC cmType = CMOpenPIC
					and: [self newMethodInLookupCacheAt: cogMethodOrPIC selector and: classTag])].
	(self lookupInMethodCacheSel: cogMethodOrPIC selector classTag: classTag)
		ifTrue:"check for coggability because method is in the cache"
			[self
				ifAppropriateCompileToNativeCode: newMethod
				selector: cogMethodOrPIC selector]
		ifFalse:
			[(objectMemory isOopForwarded: cogMethodOrPIC selector) ifTrue:
				[self handleForwardedSelectorFaultFor: cogMethodOrPIC selector.
				 ^self ceSendFromInLineCacheMiss: cogMethodOrPIC].
			 (objectMemory isForwardedClassTag: classTag) ifTrue:
				[self handleForwardedSendFaultForReceiver: rcvr stackDelta: 1 "skip return pc".
				 ^self ceSendFromInLineCacheMiss: cogMethodOrPIC].
			 messageSelector := cogMethodOrPIC selector.
			 classObj := objectMemory classForClassTag: classTag.
			 (errSelIdx := self lookupOrdinaryNoMNUEtcInClass: classObj) ~= 0 ifTrue:
				[self handleMNU: errSelIdx InMachineCodeTo: rcvr classForMessage: classObj.
				"NOTREACHED"
				self assert: false].
			 self addNewMethodToCache: classObj].
	instructionPointer := self popStack.
	(self maybeMethodHasCogMethod: newMethod) ifTrue:
		[self executeNewMethod.
		 self assert: false
		 "NOTREACHED"].
	^self interpretMethodFromMachineCode
	"NOTREACHED"