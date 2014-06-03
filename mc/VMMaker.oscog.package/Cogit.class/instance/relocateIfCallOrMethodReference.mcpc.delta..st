compaction
relocateIfCallOrMethodReference: annotation mcpc: mcpc delta: delta
	<var: #mcpc type: #'char *'>
	| entryPoint offset sendTable targetMethod unlinkedRoutine |
	<var: #sendTable type: #'sqInt *'>
	<var: #targetMethod type: #'CogMethod *'>
	(self isSendAnnotation: annotation) ifTrue:
		[entryPoint := backEnd callTargetFromReturnAddress: mcpc asInteger.
		 entryPoint <= methodZoneBase ifTrue: "send is not linked; just relocate"
			[backEnd relocateCallBeforeReturnPC: mcpc asInteger by: delta negated.
			 ^0].
		"It's a linked send; find which kind."
		self
			offsetAndSendTableFor: entryPoint
			annotation: annotation
			into: [:off :table| offset := off. sendTable := table].
		 targetMethod := self cCoerceSimple: entryPoint - offset to: #'CogMethod *'.
		 targetMethod cmType = CMMethod ifTrue: "send target not freed; just relocate."
			[backEnd
				relocateCallBeforeReturnPC: mcpc asInteger
				by: (delta - targetMethod objectHeader) negated.
			 ^0].
		"Target was freed; map back to an unlinked send; but include this method's reocation"
		 unlinkedRoutine := sendTable at: (targetMethod cmNumArgs min: NumSendTrampolines - 1).
		 unlinkedRoutine := unlinkedRoutine - delta.
		 backEnd
			rewriteInlineCacheAt: mcpc asInteger
			tag: targetMethod selector
			target: unlinkedRoutine.
		 ^0].
	annotation = IsRelativeCall ifTrue:
		[backEnd relocateCallBeforeReturnPC: mcpc asInteger by: delta negated.
		 ^0].
	annotation = IsAbsPCReference ifTrue:
		[backEnd relocateMethodReferenceBeforeAddress: mcpc asInteger by: delta].
	^0 "keep scanning"