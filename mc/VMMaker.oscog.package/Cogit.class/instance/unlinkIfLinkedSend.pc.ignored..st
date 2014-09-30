in-line cacheing
unlinkIfLinkedSend: annotation pc: mcpc ignored: superfluity
	<var: #mcpc type: #'char *'>
	| entryPoint |
	(self isSendAnnotation: annotation) ifTrue:
		[entryPoint := backEnd callTargetFromReturnAddress: mcpc asInteger.
		 entryPoint > methodZoneBase
			ifTrue: "It's a linked send."
				[self targetMethodAndSendTableFor: entryPoint into:
					[:targetMethod :sendTable| 
					 self unlinkSendAt: mcpc targetMethod: targetMethod sendTable: sendTable]]
			ifFalse:
				[self cppIf: NewspeakVM ifTrue:
					[entryPoint = ceImplicitReceiverTrampoline ifTrue:
						[self voidImplicitReceiverCacheAt: mcpc]]]].
	^0 "keep scanning"