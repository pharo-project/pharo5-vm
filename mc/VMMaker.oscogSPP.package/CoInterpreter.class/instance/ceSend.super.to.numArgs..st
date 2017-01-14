trampolines
ceSend: selector super: superNormalBar to: rcvr numArgs: numArgs
	"Entry-point for an unlinked send in a CogMethod.  Smalltalk stack looks like
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
	| classTag classObj errSelIdx cogMethod |
	<inline: false>
	<var: #cogMethod type: #'CogMethod *'>
	<var: #newCogMethod type: #'CogMethod *'>
	"self printExternalHeadFrame"
	"self printStringOf: selector"
	cogit assertCStackWellAligned.
	self assert: (objectMemory addressCouldBeOop: rcvr).
	self sendBreakpoint: selector receiver: rcvr.
	superNormalBar = 0
		ifTrue: [classTag := objectMemory fetchClassTagOf: rcvr]
		ifFalse: [classTag := objectMemory classTagForClass: (self superclassOf: (self methodClassOf: (self frameMethodObject: framePointer)))].
	argumentCount := numArgs.
	(self lookupInMethodCacheSel: selector classTag: classTag)
		ifTrue:"check for coggability because method is in the cache"
			[self
				ifAppropriateCompileToNativeCode: newMethod
				selector: selector]
		ifFalse:
			[(objectMemory isOopForwarded: selector) ifTrue:
				[^self
					ceSend: (self handleForwardedSelectorFaultFor: selector)
					super: superNormalBar
					to: rcvr
					numArgs: numArgs].
			 (objectMemory isForwardedClassTag: classTag) ifTrue:
				[self assert: superNormalBar = 0.
				^self
					ceSend: selector
					super: superNormalBar
					to: (self handleForwardedSendFaultForReceiver: rcvr stackDelta: 1 "skip return pc")
					numArgs: numArgs].
			 messageSelector := selector.
			 classObj := objectMemory classForClassTag: classTag.
			 (errSelIdx := self lookupOrdinaryNoMNUEtcInClass: classObj) ~= 0 ifTrue:
				[(errSelIdx = SelectorDoesNotUnderstand
				  and: [(cogMethod := cogit cogMNUPICSelector: messageSelector
											receiver: rcvr
											methodOperand: (self mnuMethodOrNilFor: rcvr)
											numArgs: argumentCount) asUnsignedInteger
						> cogit minCogMethodAddress]) ifTrue:
						[cogit
							linkSendAt: (stackPages longAt: stackPointer)
							in: (self mframeHomeMethod: framePointer)
							to: cogMethod
							offset: (superNormalBar = 0
									ifTrue: [cogit entryOffset]
									ifFalse: [cogit noCheckEntryOffset])
							receiver: rcvr].
				self handleMNU: errSelIdx InMachineCodeTo: rcvr classForMessage: classObj.
				self assert: false "NOTREACHED"].
			 self addNewMethodToCache: classObj].
	"Method found and has a cog method.  Attempt to link to it.  The receiver's class may be young.
	 If the Cogit can't store young classes in inline caches we can link to an open PIC instead."
	(self maybeMethodHasCogMethod: newMethod) ifTrue:
		[cogMethod := self cogMethodOf: newMethod.
		 cogMethod selector = objectMemory nilObject
			ifTrue: [cogit setSelectorOf: cogMethod to: selector]
			ifFalse:
				["Deal with anonymous accessors, e.g. in Newspeak.  The cogMethod may not have the
				  correct selector.  If not, try and compile a new method with the correct selector."
				 cogMethod selector ~= selector ifTrue:
					[(cogit cog: newMethod selector: selector) ifNotNil:
						[:newCogMethod| cogMethod := newCogMethod]]].
		 cogMethod selector = selector
			ifTrue:
				[cogit
					linkSendAt: (stackPages longAt: stackPointer)
					in: (self mframeHomeMethod: framePointer)
					to: cogMethod
					offset: (superNormalBar = 0
								ifTrue: [cogit entryOffset]
								ifFalse: [cogit noCheckEntryOffset])
					receiver: rcvr]
			ifFalse: "If patchToOpenPICFor:.. returns we're out of code memory"
				[cogit
					patchToOpenPICFor: selector
					numArgs: numArgs
					receiver: rcvr].
		 instructionPointer := self popStack.
		 self executeNewMethod.
		 self assert: false "NOTREACHED"].
	instructionPointer := self popStack.
	^self interpretMethodFromMachineCode
	"NOTREACHED"