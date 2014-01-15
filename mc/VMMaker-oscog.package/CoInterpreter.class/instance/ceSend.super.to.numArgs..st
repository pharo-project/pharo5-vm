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
	| class canLinkCacheTag errSelIdx cogMethod newCogMethod |
	<inline: false>
	<var: #cogMethod type: #'CogMethod *'>
	<var: #newCogMethod type: #'CogMethod *'>
	"self printExternalHeadFrame"
	"self printStringOf: selector"
	cogit assertCStackWellAligned.
	self assert: ((objectMemory isIntegerObject: rcvr) or: [objectMemory addressCouldBeObj: rcvr]).
	self sendBreak: selector + BaseHeaderSize
		point: (objectMemory lengthOf: selector)
		receiver: rcvr.
	superNormalBar = 0
		ifTrue: [class := objectMemory fetchClassOf: rcvr]
		ifFalse: [class := self superclassOf: (self methodClassOf: (self frameMethodObject: framePointer))].
	canLinkCacheTag := (objectMemory isYoungObject: class) not or: [cogit canLinkToYoungClasses].
	"We set the messageSelector and lkupClass for executeMethod below since things
	 like the at cache read messageSelector and lkupClass and so they cannot be left stale."
	messageSelector := selector.
	lkupClass := class.
	argumentCount := numArgs.
	(self lookupInMethodCacheSel: selector class: class)
		ifTrue:"check for coggability because method is in the cache"
			[self
				ifAppropriateCompileToNativeCode: newMethod
				selector: selector]
		ifFalse:
			[(errSelIdx := self lookupMethodNoMNUEtcInClass: class) ~= 0 ifTrue:
				[(canLinkCacheTag
				  and: [errSelIdx = SelectorDoesNotUnderstand
				  and: [(cogMethod := cogit cogMNUPICSelector: messageSelector
											methodOperand: (self mnuMethodOrNilFor: rcvr)
											numArgs: argumentCount) asUnsignedInteger
						> cogit minCogMethodAddress]]) ifTrue:
						[cogit
							linkSendAt: (stackPages longAt: stackPointer)
							in: (self mframeHomeMethod: framePointer)
							to: cogMethod
							offset: (superNormalBar = 0
									ifTrue: [cogit entryOffset]
									ifFalse: [cogit noCheckEntryOffset])
							receiver: rcvr].
				self handleMNU: errSelIdx InMachineCodeTo: rcvr classForMessage: class.
				"NOTREACHED"
				self assert: false]].
	"Method found and has a cog method.  Attempt to link to it.  The receiver's class may be young.
	 If the Cogit can't store young classes in inline caches we can link to an open PIC instead."
	(self maybeMethodHasCogMethod: newMethod) ifTrue:
		[cogMethod := self cogMethodOf: newMethod.
		 cogMethod selector = objectMemory nilObject ifTrue:
			[cogit setSelectorOf: cogMethod to: selector].
		 "Deal with anonymous accessors, e.g. in Newspeak.  The cogMethod may not have the correct
		  selector.  If not, try and compile a new method with the correct selector."
		 cogMethod selector ~= selector ifTrue:
			[self assert: (self methodClassAssociationOf: newMethod) = objectMemory nilObject.
			 newCogMethod := cogit cog: newMethod selector: selector.
			 newCogMethod ifNotNil:
				[cogMethod := newCogMethod]].
		 (cogMethod selector = selector
		  and: [canLinkCacheTag])
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
		 self assert: false
		 "NOTREACHED"].
	instructionPointer := self popStack.
	^self interpretMethodFromMachineCode
	"NOTREACHED"