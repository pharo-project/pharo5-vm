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
	| class classTag canLinkCacheTag errSelIdx cogMethod mClassMixin mixinApplication |
	<inline: false>
	<var: #cogMethod type: #'CogMethod *'>
	<var: #newCogMethod type: #'CogMethod *'>
	"self printExternalHeadFrame"
	"self printStringOf: selector"
	cogit assertCStackWellAligned.
	self assert: (objectMemory addressCouldBeOop: rcvr).
	self sendBreakpoint: selector receiver: rcvr.
	mClassMixin := self mMethodClass.
	mixinApplication := self 
							findApplicationOfTargetMixin: mClassMixin
							startingAtBehavior: (objectMemory fetchClassOf: rcvr).
	self assert: (objectMemory lengthOf: mixinApplication) > (InstanceSpecificationIndex + 1).
	classTag := objectMemory classTagForClass: (self superclassOf: mixinApplication).
	class := objectMemory fetchClassOf: rcvr. "what about the read barrier??"
	canLinkCacheTag := (objectMemory isYoungObject: class) not or: [cogit canLinkToYoungClasses].
	argumentCount := numArgs.
	(self lookupInMethodCacheSel: selector classTag: classTag)
		ifTrue:"check for coggability because method is in the cache"
			[self
				ifAppropriateCompileToNativeCode: newMethod
				selector: selector]
		ifFalse:
			[(objectMemory isOopForwarded: selector) ifTrue:
				[^self
					ceDynamicSuperSend: (self handleForwardedSelectorFaultFor: selector)
					to: rcvr
					numArgs: numArgs].
			 (objectMemory isForwardedClassTag: classTag) ifTrue:
				[^self
					ceDynamicSuperSend: selector
					to: (self handleForwardedSendFaultForReceiver: rcvr stackDelta: 1 "skip return pc")
					numArgs: numArgs].
			 messageSelector := selector.
			 (errSelIdx := self lookupMethodNoMNUEtcInClass: (objectMemory classForClassTag: classTag)) ~= 0 ifTrue:
				[self handleMNU: errSelIdx InMachineCodeTo: rcvr classForMessage: (objectMemory classForClassTag: classTag).
				self assert: false "NOTREACHED"]].
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
		 self assert: false "NOTREACHED"].
	instructionPointer := self popStack.
	^self interpretMethodFromMachineCode
	"NOTREACHED"