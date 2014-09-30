in-line cacheing
unlinkIfFreeOrLinkedSend: annotation pc: mcpc of: theSelector
	<var: #mcpc type: #'char *'>
	| entryPoint |
	(self isSendAnnotation: annotation) ifTrue:
		[entryPoint := backEnd callTargetFromReturnAddress: mcpc asInteger.
		 entryPoint > methodZoneBase
			ifTrue: "It's a linked send."
				[self targetMethodAndSendTableFor: entryPoint into:
					[:targetMethod :sendTable| 
					 (targetMethod cmType = CMFree
					  or: [targetMethod selector = theSelector]) ifTrue:
						[self unlinkSendAt: mcpc targetMethod: targetMethod sendTable: sendTable]]]
			ifFalse:
				[self cppIf: NewspeakVM ifTrue:
					[(entryPoint = ceImplicitReceiverTrampoline
					 and: [(backEnd inlineCacheTagAt: mcpc asInteger) = theSelector]) ifTrue:
					 	[self voidImplicitReceiverCacheAt: mcpc]]]].
	^0 "keep scanning"