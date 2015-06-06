in-line cacheing
linkSendAt: callSiteReturnAddress in: sendingMethod to: targetMethod offset: theEntryOffset receiver: receiver
	<api>
	<var: #sendingMethod type: #'CogMethod *'>
	<var: #targetMethod type: #'CogMethod *'>
	| inlineCacheTag address extent |
	self assert: (theEntryOffset = cmEntryOffset or: [theEntryOffset = cmNoCheckEntryOffset]).
	self assert: (callSiteReturnAddress between: methodZoneBase and: methodZone freeStart).
	inlineCacheTag := theEntryOffset = cmNoCheckEntryOffset
						ifTrue: [targetMethod selector "i.e. no change"]
						ifFalse: [objectRepresentation inlineCacheTagForInstance: receiver].
	(objectRepresentation inlineCacheTagIsYoung: inlineCacheTag) ifTrue:
		[methodZone ensureInYoungReferrers: sendingMethod].
	address := targetMethod asInteger + theEntryOffset.
	extent := backEnd
				rewriteInlineCacheAt: callSiteReturnAddress
				tag: inlineCacheTag
				target: address.
	processor
		flushICacheFrom: callSiteReturnAddress asUnsignedInteger  - extent
		to: callSiteReturnAddress asUnsignedInteger 