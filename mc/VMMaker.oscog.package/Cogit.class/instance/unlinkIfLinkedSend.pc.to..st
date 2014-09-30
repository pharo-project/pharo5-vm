in-line cacheing
unlinkIfLinkedSend: annotation pc: mcpc to: theCogMethod
	<var: #mcpc type: #'char *'>
	| entryPoint |
	(self isSendAnnotation: annotation) ifTrue:
		[entryPoint := backEnd callTargetFromReturnAddress: mcpc asInteger.
		 entryPoint > methodZoneBase
			ifTrue: "It's a linked send."
				[self targetMethodAndSendTableFor: entryPoint into:
					[:targetMethod :sendTable| 
					 targetMethod asInteger = theCogMethod ifTrue:
						[self unlinkSendAt: mcpc targetMethod: targetMethod sendTable: sendTable]]]
			ifFalse: "Can't tell the target with PushReciver/SendImplicit so flush anyway."
				[self cppIf: NewspeakVM ifTrue:
					[entryPoint = ceImplicitReceiverTrampoline ifTrue:
						[self voidImplicitReceiverCacheAt: mcpc]]]].
	^0 "keep scanning"