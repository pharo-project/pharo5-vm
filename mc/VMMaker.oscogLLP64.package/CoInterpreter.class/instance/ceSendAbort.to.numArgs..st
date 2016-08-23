trampolines
ceSendAbort: selector to: rcvr numArgs: numArgs
	"Entry-point for an abort send in a CogMethod (aboutToReturn:through:, cannotReturn: et al).
	 Try and dispatch the send, but the send may turn into an MNU in which case defer to
	 handleMNUInMachineCodeTo:... which will dispatch the MNU.

	 Continue execution via either executeMethod or interpretMethodFromMachineCode:
	 depending on whether the target method is cogged or not."
	<api>
	| classTag classObj errSelIdx |
	<inline: false>
	"self printExternalHeadFrame"
	"self printStringOf: selector"
	cogit assertCStackWellAligned.
	self assert: (objectMemory addressCouldBeOop: rcvr).
	self sendBreakpoint: selector receiver: rcvr.
	argumentCount := numArgs.
	classTag := objectMemory fetchClassTagOf: rcvr.
	(self lookupInMethodCacheSel: selector classTag: classTag)
		ifTrue:"check for coggability because method is in the cache"
			[self
				ifAppropriateCompileToNativeCode: newMethod
				selector: selector]
		ifFalse:
			[messageSelector := selector.
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