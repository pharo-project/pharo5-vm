trampolines
ceSelfSend: selector to: rcvr numArgs: numArgs
	"Entry-point for an unlinked self send in a CogMethod.  Smalltalk stack looks like
					receiver
					args
		head sp ->	sender return pc
		
	If an MNU then defer to handleMNUInMachineCodeTo:... which will dispatch the MNU and
	may choose to allocate a closed PIC with a fast MNU dispatch for this send.  Otherwise
	attempt to link the send site as efficiently as possible.  All link attempts may fail; e.g.
	because we're out of code memory.

	Continue execution via either executeMethod or interpretMethodFromMachineCode:
	depending on whether the target method is cogged or not."
	<api>
	<option: #NewspeakVM>
	| classTag errSelIdx cogMethod |
	<inline: false>
	<var: #cogMethod type: #'CogMethod *'>
	<var: #newCogMethod type: #'CogMethod *'>

	cogit assertCStackWellAligned.
	self assert: (objectMemory addressCouldBeOop: rcvr).
	self sendBreakpoint: selector receiver: rcvr.

	classTag := objectMemory fetchClassTagOf: rcvr.
	messageSelector := selector.
	argumentCount := numArgs.
	method := (self mframeHomeMethod: framePointer) methodObject.

	(self
		inlineLookupInNSMethodCacheSel: messageSelector
		classTag: classTag
		method: method
		lookupRule: LookupRuleSelf)
			ifTrue:
				["check for coggability because method is in the cache"
				self
					ifAppropriateCompileToNativeCode: newMethod
					selector: selector]
			ifFalse:
				[(objectMemory isOopForwarded: selector) ifTrue:
					[self
						ceSelfSend: (self handleForwardedSelectorFaultFor: selector)
						to: rcvr
						numArgs: numArgs.
					self unreachable].
			 	(objectMemory isForwardedClassTag: classTag) ifTrue:
					[self
						ceSelfSend: selector
						to: (self handleForwardedSendFaultForReceiver: rcvr stackDelta: 1 "skip return pc")
						numArgs: numArgs.
					self unreachable].
				lkupClassTag := classTag.
				errSelIdx := self lookupOuterSendNoMNU: rcvr depth: 0.
				errSelIdx ~= 0 ifTrue:
					[self assert: errSelIdx == SelectorDoesNotUnderstand.
					self handleMNU: errSelIdx 
						InMachineCodeTo: rcvr
						classForMessage: (objectMemory classForClassTag: classTag).
					self unreachable].
				self addNewMethodToNSCache: LookupRuleSelf].

	"Method found and has a cog method.  Attempt to link to it."
	(self maybeMethodHasCogMethod: newMethod) ifTrue:
		[cogMethod := self cogMethodOf: newMethod.
		 cogMethod selector = objectMemory nilObject
			ifTrue: [cogit setSelectorOf: cogMethod to: selector]
			ifFalse:
				["Deal with anonymous accessors, e.g. in Newspeak.  The cogMethod may not have the correct
				  selector.  If not, try and compile a new method with the correct selector."
				 cogMethod selector ~= selector ifTrue:
					[(cogit cog: newMethod selector: selector) ifNotNil:
						[:newCogMethod| cogMethod := newCogMethod]]].
		 cogMethod selector = selector ifTrue:
			[cogit
				linkSendAt: (stackPages longAt: stackPointer)
				in: (self mframeHomeMethod: framePointer)
				to: cogMethod
				offset: cogit entryOffset
				receiver: rcvr].
		 instructionPointer := self popStack.
		 self executeNewMethod.
		 self unreachable].
	instructionPointer := self popStack.
	self interpretMethodFromMachineCode.
	self unreachable.