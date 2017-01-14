in-line cacheing
cPICHasForwardedClass: cPIC 
	"The first case in a CPIC doesn't have a class reference so we need only step over actually usd subsequent cases."
	| pc |
	<var: #cPIC type: #'CogMethod *'>
	"start by finding the address of the topmost case, the cPICNumCases'th one"
	pc := (self addressOfEndOfCase: cPIC cPICNumCases inCPIC: cPIC)
				- backEnd jumpLongConditionalByteSize.
	2 to: cPIC cPICNumCases do: 
			[:i |  | classIndex |
			classIndex := backEnd literal32BeforeFollowingAddress: pc.
			(objectMemory isForwardedClassIndex: classIndex)
				ifTrue: [^ true].
			"since we started at the top, we can just add the case size each time to move on to the next case"
			pc := pc + cPICCaseSize].
	^ false