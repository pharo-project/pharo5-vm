trampolines
ceImplicitReceiverSend: cacheAddress receiver: methodReceiver
	"An implicit receiver send cache missed."
	| nsSendCache methodReceiverClassTag cogMethod errSelIdx |
	<api>
	<option: #NewspeakVM>
	<inline: false>
	<var: #nsSendCache type: #'NSSendCache *'>
	<var: #cogMethod type: #'CogMethod *'>

	cogit assertCStackWellAligned.
	self assert: (objectMemory addressCouldBeOop: methodReceiver).
	self deny: (objectMemory isOopForwarded: methodReceiver).

	nsSendCache := self cCoerceSimple: cacheAddress to: #'NSSendCache *'.
	messageSelector := nsSendCache selector.
	argumentCount := nsSendCache numArgs.
	method := (self mframeHomeMethod: framePointer) methodObject.

	self assert: (self stackValue: argumentCount + 1 "ret addr") = methodReceiver.

	methodReceiverClassTag := objectMemory fetchClassTagOf: methodReceiver.

	(self
		inlineLookupInNSMethodCacheSel: messageSelector
		classTag: methodReceiverClassTag
		method: method
		lookupRule: LookupRuleImplicit)
			ifTrue:
				[localAbsentReceiverOrZero = 0
					ifTrue: [localAbsentReceiver := methodReceiver]
					ifFalse: [localAbsentReceiver := localAbsentReceiverOrZero].
				"check for coggability because method is in the cache"
				self ifAppropriateCompileToNativeCode: newMethod selector: messageSelector]
			ifFalse:
				[self deny: (objectMemory isOopForwarded: messageSelector).
				self deny: (objectMemory isForwardedClassTag: methodReceiverClassTag).
				errSelIdx := self lookupImplicitReceiverSendNoMNU: methodReceiver.
				errSelIdx ~= 0 ifTrue:
					[self assert: errSelIdx == SelectorDoesNotUnderstand.
					self assert: localAbsentReceiver == methodReceiver.
					self handleMNU: errSelIdx 
						InMachineCodeTo: methodReceiver
						classForMessage: lkupClass.
					self unreachable].
				lkupClassTag := methodReceiverClassTag.
				self addNewMethodToNSCache: LookupRuleImplicit].

	"Fix stacked receiver."
	self stackValue: argumentCount + 1 "ret addr" put: localAbsentReceiver.

	(self maybeMethodHasCogMethod: newMethod) 
		ifTrue: [
			cogMethod := self cogMethodOf: newMethod.
			cogMethod selector = objectMemory nilObject
				ifTrue: [cogit setSelectorOf: cogMethod to: messageSelector]
				ifFalse: ["Deal with anonymous accessors, e.g. in Newspeak.
					The cogMethod may not have the
					correct selector. If not, try and compile a new method
					with the correct selector."
					cogMethod selector ~= messageSelector ifTrue: [
							(cogit cog: newMethod selector: messageSelector)
								ifNotNil: [:newCogMethod | cogMethod := newCogMethod]]].
			cogMethod selector = messageSelector
				ifTrue:
					[cogit
						linkNSSendCache: nsSendCache 
						classTag: methodReceiverClassTag
						enclosingObject: localAbsentReceiverOrZero
						target: cogMethod
						caller: self mframeHomeMethodExport]
				ifFalse: ["Out of code memory. Fall through to interpret."].
			instructionPointer := self popStack.
			self executeNewMethod.
			self unreachable].
	instructionPointer := self popStack.
	self interpretMethodFromMachineCode.
	self unreachable.