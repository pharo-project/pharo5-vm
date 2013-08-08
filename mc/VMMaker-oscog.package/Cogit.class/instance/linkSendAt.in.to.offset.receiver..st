in-line cacheing
linkSendAt: callSiteReturnAddress in: sendingMethod to: targetMethod offset: theEntryOffset receiver: receiver
	<api>
	<var: #sendingMethod type: #'CogMethod *'>
	<var: #targetMethod type: #'CogMethod *'>
	| inlineCacheTag address extent |
	self cppIf: NewspeakVM
		ifTrue: [self assert: (theEntryOffset = cmEntryOffset
							or: [theEntryOffset = cmNoCheckEntryOffset
							or: [theEntryOffset = cmDynSuperEntryOffset]])]
		ifFalse: [self assert: (theEntryOffset = cmEntryOffset
							or: [theEntryOffset = cmNoCheckEntryOffset])].
	self assert: (callSiteReturnAddress between: methodZoneBase and: methodZone freeStart).
	inlineCacheTag := theEntryOffset = cmNoCheckEntryOffset
						ifTrue: [targetMethod selector "i.e. no change"]
						ifFalse: [objectRepresentation inlineCacheTagForInstance: receiver].
	(sendingMethod cmRefersToYoung not
	 and: [(objectRepresentation inlineCacheTagIsYoung: inlineCacheTag)]) ifTrue:
		[self assert: (methodZone occurrencesInYoungReferrers: sendingMethod) = 0.
		 sendingMethod cmRefersToYoung: true.
		 methodZone addToYoungReferrers: sendingMethod].
	address := targetMethod asInteger + theEntryOffset.
	extent := backEnd
				rewriteInlineCacheAt: callSiteReturnAddress
				tag: inlineCacheTag
				target: address.
	processor
		flushICacheFrom: callSiteReturnAddress - 1 - extent
		to: callSiteReturnAddress - 1