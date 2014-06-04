in-line cacheing
ceSICMiss: receiver
	"An in-line cache check in a method has failed.  The failing entry check has jumped
	 to the ceMethodAbort abort call at the start of the method which has called this routine.
	 If possible allocate a closed PIC for the current and existing classes.
	 The stack looks like:
			receiver
			args
			sender return address
	  sp=>	ceMethodAbort call return address
	 So we can find the method that did the failing entry check at
		ceMethodAbort call return address - missOffset
	 and we can find the send site from the outer return address."
	<api>
	| pic innerReturn outerReturn entryPoint targetMethod newTargetMethodOrNil errorSelectorOrNil cacheTag extent result |
	<var: #pic type: #'CogMethod *'>
	<var: #targetMethod type: #'CogMethod *'>
	"Whether we can relink to a PIC or not we need to pop off the inner return and identify the target method."
	innerReturn := coInterpreter popStack.
	targetMethod := self cCoerceSimple: innerReturn - missOffset to: #'CogMethod *'.
	(objectMemory isOopForwarded: receiver) ifTrue:
		[^coInterpreter ceSendFromInLineCacheMiss: targetMethod].
	outerReturn := coInterpreter stackTop.
	self assert: (outerReturn between: methodZoneBase and: methodZone freeStart).
	entryPoint := backEnd callTargetFromReturnAddress: outerReturn.

	self assert: targetMethod selector ~= objectMemory nilObject.
	self cppIf: NewspeakVM ifTrue:
		[self assert: (targetMethod asInteger + cmEntryOffset = entryPoint
					or: [targetMethod asInteger + cmDynSuperEntryOffset = entryPoint]).
		 "Avoid the effort of implementing PICs for the relatively low dynamic frequency
		  dynamic super send and simply rebind the send site."
		 targetMethod asInteger + cmDynSuperEntryOffset = entryPoint ifTrue:
			[^coInterpreter
				ceDynamicSuperSend: targetMethod selector
				to: receiver
				numArgs: targetMethod cmNumArgs]].
	self assert: targetMethod asInteger + cmEntryOffset = entryPoint.

	self lookup: targetMethod selector
		for: receiver
		methodAndErrorSelectorInto:
			[:method :errsel|
			newTargetMethodOrNil := method.
			errorSelectorOrNil := errsel].
	"We assume lookupAndCog:for: will *not* reclaim the method zone"
	self assert: outerReturn = coInterpreter stackTop.
	cacheTag := objectRepresentation inlineCacheTagForInstance: receiver.
	((errorSelectorOrNil notNil and: [errorSelectorOrNil ~= SelectorDoesNotUnderstand])
	 or: [(objectRepresentation inlineCacheTagIsYoung: cacheTag)
	 or: [newTargetMethodOrNil isNil
	 or: [objectMemory isYoung: newTargetMethodOrNil]]]) ifTrue:
		[result := self patchToOpenPICFor: targetMethod selector
					numArgs: targetMethod cmNumArgs
					receiver: receiver.
		 self assert: result not. "If patchToOpenPICFor:.. returns we're out of code memory"
		 ^coInterpreter ceSendFromInLineCacheMiss: targetMethod].
	"See if an Open PIC is already available."
	pic := methodZone openPICWithSelector: targetMethod selector.
	pic isNil ifTrue:
		["otherwise attempt to create a closed PIC for the two cases."
		 pic := self cogPICSelector: targetMethod selector
					numArgs: targetMethod cmNumArgs
					Case0Method: targetMethod
					Case1Method: newTargetMethodOrNil
					tag: cacheTag
					isMNUCase: errorSelectorOrNil = SelectorDoesNotUnderstand.
		 (pic asInteger between: MaxNegativeErrorCode and: -1) ifTrue:
			["For some reason the PIC couldn't be generated, most likely a lack of code memory.
			  Continue as if this is an unlinked send."
			 pic asInteger = InsufficientCodeSpace ifTrue:
				[coInterpreter callForCogCompiledCodeCompaction].
			^coInterpreter ceSendFromInLineCacheMiss: targetMethod].
		 processor flushICacheFrom: pic asInteger to: pic asInteger + closedPICSize].
	"Relink the send site to the pic.  If to an open PIC then reset the cache tag to the selector,
	 for the benefit of the cacheTag assert check in checkIfValidObjectRef:pc:cogMethod:."
	extent := pic cmType = CMOpenPIC
				ifTrue:
					[backEnd
						rewriteInlineCacheAt: outerReturn
						tag: targetMethod selector
						target: pic asInteger + cmEntryOffset]
				ifFalse:
					[backEnd
						rewriteCallAt: outerReturn
						target: pic asInteger + cmEntryOffset].
	processor flushICacheFrom: outerReturn - 1 - extent to: outerReturn - 1.
	"Jump back into the pic at its entry in case this is an MNU (newTargetMethodOrNil is nil)"
	coInterpreter
		executeCogMethod: pic
		fromLinkedSendWithReceiver: receiver
		andCacheTag: (backEnd inlineCacheTagAt: outerReturn).
	"NOTREACHED"
	^nil