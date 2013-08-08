trampolines
ceSendAbort: selector to: rcvr numArgs: numArgs
	"Entry-point for an abort send in a CogMethod (aboutToReturn:through:, cannotReturn: et al).
	 Try and dispatch the send, but the send may turn into an MNU in which case defer to
	 handleMNUInMachineCodeTo:... which will dispatch the MNU.

	 Continue execution via either executeMethod or interpretMethodFromMachineCode:
	 depending on whether the target method is cogged or not."
	<api>
	| class errSelIdx |
	<inline: false>
	"self printExternalHeadFrame"
	"self printStringOf: selector"
	cogit assertCStackWellAligned.
	self assert: ((objectMemory isIntegerObject: rcvr) or: [objectMemory addressCouldBeObj: rcvr]).
	self sendBreak: selector + BaseHeaderSize
		point: (objectMemory lengthOf: selector)
		receiver: rcvr.
	argumentCount := numArgs.
	"We set the messageSelector and lkupClass for executeMethod below since things
	 like the at cache read messageSelector and lkupClass and so they cannot be left stale."
	messageSelector := selector.
	lkupClass := class := objectMemory fetchClassOf: rcvr.
	(self lookupInMethodCacheSel: selector class: class)
		ifTrue:"check for coggability because method is in the cache"
			[self
				ifAppropriateCompileToNativeCode: newMethod
				selector: selector]
		ifFalse:
			[(errSelIdx := self lookupMethodNoMNUEtcInClass: class) ~= 0 ifTrue:
				[self handleMNU: errSelIdx InMachineCodeTo: rcvr classForMessage: class.
				"NOTREACHED"
				self assert: false]].
	instructionPointer := self popStack.
	(self maybeMethodHasCogMethod: newMethod) ifTrue:
		[self executeNewMethod.
		 self assert: false
		 "NOTREACHED"].
	^self interpretMethodFromMachineCode
	"NOTREACHED"