in-line cacheing
cPICHasForwardedClass: cPIC
	<var: #cPIC type: #'CogMethod *'>
	| pc |
	pc := cPIC asUnsignedInteger
		+ firstCPICCaseOffset
		+ cPICCaseSize
		- backEnd jumpLongConditionalByteSize.
	2 to: cPIC cPICNumCases do:
		[:i| | classIndex |
		classIndex := backEnd inlineCacheTagAt: pc.
		(objectMemory isForwardedClassIndex: classIndex) ifTrue:
			[^true].
		pc := pc + cPICCaseSize].
	^false