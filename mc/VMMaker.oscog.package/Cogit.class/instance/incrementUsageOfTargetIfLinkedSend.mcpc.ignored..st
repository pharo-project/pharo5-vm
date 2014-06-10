compaction
incrementUsageOfTargetIfLinkedSend: annotation mcpc: mcpc ignored: superfluity
	<var: #mcpc type: #'char *'>
	| entryPoint |
	(self isSendAnnotation: annotation) ifTrue:
		[entryPoint := backEnd callTargetFromReturnAddress: mcpc asInteger.
		 entryPoint > methodZoneBase ifTrue: "It's a linked send."
			[self targetMethodAndSendTableFor: entryPoint into:
				[:targetMethod :sendTable|
				 targetMethod cmUsageCount < (CMMaxUsageCount // 2) ifTrue:
					[targetMethod cmUsageCount: targetMethod cmUsageCount + 1]]]].
	^0 "keep scanning"