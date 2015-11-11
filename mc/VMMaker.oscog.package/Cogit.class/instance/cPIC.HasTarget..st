in-line cacheing
cPIC: cPIC HasTarget: targetMethod
	"Are any of the jumps from this CPIC to targetMethod?"
	<var: #cPIC type: #'CogMethod *'>
	<var: #targetMethod type: #'CogMethod *'>
	| pc target |
	target := targetMethod asUnsignedInteger + cmNoCheckEntryOffset.
	pc := cPIC asInteger + firstCPICCaseOffset.
	"Since this is a fast test doing simple compares we don't need to care that some
	cases have nonsense addresses in there. Just zip on through"
	1 to: maxCPICCases do:
		[:i|
		target = (backEnd jumpLongTargetBeforeFollowingAddress: pc) ifTrue:
			[^true].
		pc := pc + cPICCaseSize].
	^false