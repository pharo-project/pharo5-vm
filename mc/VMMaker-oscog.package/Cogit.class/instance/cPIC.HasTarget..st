in-line cacheing
cPIC: cPIC HasTarget: targetMethod
	<var: #cPIC type: #'CogMethod *'>
	<var: #targetMethod type: #'CogMethod *'>
	| pc target |
	target := targetMethod asUnsignedInteger + cmNoCheckEntryOffset.
	pc := cPIC asInteger + firstCPICCaseOffset.
	1 to: cPIC cPICNumCases do:
		[:i|
		target = (backEnd jumpLongTargetBeforeFollowingAddress: pc) ifTrue:
			[^true].
		pc := pc + cPICCaseSize].
	^false