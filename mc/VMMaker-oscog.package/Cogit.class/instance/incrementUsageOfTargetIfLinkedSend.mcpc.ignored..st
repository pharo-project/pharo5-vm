compaction
incrementUsageOfTargetIfLinkedSend: annotation mcpc: mcpc ignored: superfluity
	<var: #mcpc type: #'char *'>
	| entryPoint offset targetMethod |
	<var: #targetMethod type: #'CogMethod *'>
	(self isSendAnnotation: annotation) ifTrue:
		[entryPoint := backEnd callTargetFromReturnAddress: mcpc asInteger.
		 entryPoint > methodZoneBase ifTrue: "It's a linked send."
			[self
				offsetAndSendTableFor: entryPoint
				annotation: annotation
				into: [:off :table| offset := off].
			targetMethod := self cCoerceSimple: entryPoint - offset to: #'CogMethod *'.
			targetMethod cmUsageCount < (CMMaxUsageCount // 2) ifTrue:
				[targetMethod cmUsageCount: targetMethod cmUsageCount + 1]]].
	^0 "keep scanning"