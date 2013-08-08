in-line cacheing
unlinkIfLinkedSendToFree: annotation pc: mcpc ignored: superfluity
	<var: #mcpc type: #'char *'>
	| entryPoint targetMethod offset sendTable unlinkedRoutine |
	<var: #targetMethod type: #'CogMethod *'>
	<var: #sendTable type: #'sqInt *'>
	(self isSendAnnotation: annotation) ifTrue:
		[entryPoint := backEnd callTargetFromReturnAddress: mcpc asInteger.
		 entryPoint > methodZoneBase ifTrue: "It's a linked send."
			[self
				offsetAndSendTableFor: entryPoint
				annotation: annotation
				into: [:off :table| offset := off. sendTable := table].
			targetMethod := self cCoerceSimple: entryPoint - offset to: #'CogMethod *'.
			targetMethod cmType = CMFree ifTrue:
				[unlinkedRoutine := sendTable at: (targetMethod cmNumArgs min: NumSendTrampolines - 1).
				 backEnd
					rewriteInlineCacheAt: mcpc asInteger
					tag: targetMethod selector
					target: unlinkedRoutine.
				 codeModified := true]]].
	^0 "keep scanning"