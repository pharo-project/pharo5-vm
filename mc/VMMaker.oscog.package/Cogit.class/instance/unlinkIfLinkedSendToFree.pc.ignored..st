in-line cacheing
unlinkIfLinkedSendToFree: annotation pc: mcpc ignored: superfluity
	<var: #mcpc type: #'char *'>
	| entryPoint |
	(self isSendAnnotation: annotation) ifTrue:
		[entryPoint := backEnd callTargetFromReturnAddress: mcpc asInteger.
		 entryPoint > methodZoneBase ifTrue: "It's a linked send."
			[self targetMethodAndSendTableFor: entryPoint into:
				[:targetMethod :sendTable| 
				 targetMethod cmType = CMFree ifTrue:
					[self unlinkSendAt: mcpc targetMethod: targetMethod sendTable: sendTable]]]].
	^0 "keep scanning"