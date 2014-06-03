in-line cacheing
unlinkIfLinkedSendToFree: annotation pc: mcpc ignored: superfluity
	<var: #mcpc type: #'char *'>
	| entryPoint |
	(self isSendAnnotation: annotation) ifTrue:
		[entryPoint := backEnd callTargetFromReturnAddress: mcpc asInteger.
		 entryPoint > methodZoneBase ifTrue: "It's a linked send."
			[self targetMethodAndSendTableFor: entryPoint into:
				[:targetMethod :sendTable| | unlinkedRoutine |
				 targetMethod cmType = CMFree ifTrue:
					[unlinkedRoutine := sendTable at: (targetMethod cmNumArgs min: NumSendTrampolines - 1).
					 backEnd
						rewriteInlineCacheAt: mcpc asInteger
						tag: targetMethod selector
						target: unlinkedRoutine.
					 codeModified := true]]]].
	^0 "keep scanning"