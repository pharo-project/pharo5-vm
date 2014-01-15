trampolines
ceDynamicSuperSend: selector to: rcvr numArgs: numArgs
	"Entry-point for an unlinked dynamic super send in a CogMethod.  Smalltalk stack looks like
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
	| class canLinkCacheTag errSelIdx cogMethod newCogMethod mClassMixin mixinApplication |
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
	mClassMixin := self mMethodClass.
	mixinApplication := self 
							findApplicationOfTargetMixin: mClassMixin
							startingAtBehavior: (objectMemory fetchClassOf: rcvr).
	self assert: (objectMemory lengthOf: mixinApplication) > (InstanceSpecificationIndex + 1).
	lkupClass := self superclassOf: mixinApplication.
	class := objectMemory fetchClassOf: rcvr.
	canLinkCacheTag := (objectMemory isYoungObject: class) not or: [cogit canLinkToYoungClasses].
	"We set the messageSelector and lkupClass for executeMethod below since things
	 like the at cache read messageSelector and lkupClass and so they cannot be left stale."
	messageSelector := selector.
	lkupClass := self superclassOf: mixinApplication.
	argumentCount := numArgs.
	(self lookupInMethodCacheSel: selector class: lkupClass)
		ifTrue:"check for coggability because method is in the cache"
			[self
				ifAppropriateCompileToNativeCode: newMethod
				selector: selector]
		ifFalse:
			[(errSelIdx := self lookupMethodNoMNUEtcInClass: lkupClass) ~= 0 ifTrue:
				[self handleMNU: errSelIdx InMachineCodeTo: rcvr classForMessage: lkupClass.
				"NOTREACHED"
				self assert: false]].
	"Method found and has a cog method.  Attempt to link to it."
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
		 and: [canLinkCacheTag]) ifTrue:
			[cogit
				linkSendAt: (stackPages longAt: stackPointer)
				in: (self mframeHomeMethod: framePointer)
				to: cogMethod
				offset: cogit dynSuperEntryOffset
				receiver: rcvr].
		 instructionPointer := self popStack.
		 self executeNewMethod.
		 self assert: false
		 "NOTREACHED"].
	instructionPointer := self popStack.
	^self interpretMethodFromMachineCode
	"NOTREACHED"