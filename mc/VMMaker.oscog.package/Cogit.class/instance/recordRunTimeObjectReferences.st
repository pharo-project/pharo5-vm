initialization
recordRunTimeObjectReferences
	| annotation |
	<var: #annotation type: #'InstructionAnnotation *'>
	0 to: annotationIndex - 1 do:
		[:i|
		annotation := self addressOf: (annotations at: i).
		annotation annotation = IsObjectReference ifTrue:
			[self assert: runtimeObjectRefIndex < NumObjRefsInRuntime.
			 self assert: hasYoungReferent not.
			 hasYoungReferent ifTrue:
				[self error: 'attempt to generate run-time routine containing young object reference.  Cannot initialize Cogit run-time.'].
			 objectReferencesInRuntime
				at: runtimeObjectRefIndex
				put: (annotation instruction address + annotation instruction machineCodeSize) asInteger.
			 runtimeObjectRefIndex := runtimeObjectRefIndex + 1]].
	annotationIndex := 0