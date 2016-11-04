in-line cacheing
ceCPICMiss: cPIC receiver: receiver
	"Code entry closed PIC miss.  A send has fallen
	 through a closed (finite) polymorphic inline cache.
	 Either extend it or patch the send site to an open PIC.
	 The stack looks like:
			receiver
			args
	  sp=>	sender return address"
	<var: #cPIC type: #'CogMethod *'>
	<api>
	| outerReturn newTargetMethodOrNil errorSelectorOrNil cacheTag result |
	self cCode: ''
		inSmalltalk:
			[cPIC isInteger ifTrue:
				[^self ceCPICMiss: (self cogMethodSurrogateAt: cPIC) receiver: receiver]].
	(objectMemory isOopForwarded: receiver) ifTrue:
		[^coInterpreter ceSendFromInLineCacheMiss: cPIC].
	outerReturn := coInterpreter stackTop.
	self deny: (backEnd inlineCacheTagAt: outerReturn) = self picAbortDiscriminatorValue. 
	cPIC cPICNumCases < MaxCPICCases
		ifTrue:
			[self lookup: cPIC selector
				for: receiver
				methodAndErrorSelectorInto:
					[:method :errsel|
					newTargetMethodOrNil := method.
					errorSelectorOrNil := errsel]]
		ifFalse: [newTargetMethodOrNil := errorSelectorOrNil := nil].
	"We assume lookupAndCog:for: will *not* reclaim the method zone"
	self assert: outerReturn = coInterpreter stackTop.
	cacheTag := objectRepresentation inlineCacheTagForInstance: receiver.
	(cPIC cPICNumCases >= MaxCPICCases
	 or: [(errorSelectorOrNil notNil and: [errorSelectorOrNil ~= SelectorDoesNotUnderstand])
	 or: [(objectRepresentation inlineCacheTagIsYoung: cacheTag)
	 or: [newTargetMethodOrNil isNil
	 or: [objectMemory isYoung: newTargetMethodOrNil]]]]) ifTrue:
		[result := self patchToOpenPICFor: cPIC selector
					numArgs: cPIC cmNumArgs
					receiver: receiver.
		 self assert: result not. "If patchToOpenPICFor:.. returns we're out of code memory"
		 ^coInterpreter ceSendFromInLineCacheMiss: cPIC].
	"Now extend the PIC with the new case."
	self cogExtendPIC: cPIC
		CaseNMethod: newTargetMethodOrNil
		tag: cacheTag
		isMNUCase: errorSelectorOrNil = SelectorDoesNotUnderstand.
	"Jump back into the pic at its entry in case this is an MNU."
	coInterpreter
		executeCogPIC: cPIC
		fromLinkedSendWithReceiver: receiver
		andCacheTag: (backEnd inlineCacheTagAt: outerReturn).
	"NOTREACHED"
	^nil