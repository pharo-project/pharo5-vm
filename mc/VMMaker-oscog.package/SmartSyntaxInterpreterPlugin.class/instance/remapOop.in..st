simulation
remapOop: oopOrList in: aBlock
	<doNotGenerate>
	| numIncrGCs numFullGCs result |
	numIncrGCs := interpreterProxy statIncrGCs.
	numFullGCs := interpreterProxy statFullGCs.
	result := aBlock value.
	"If you really did want to implement remapping you would try and locate the
	 arguments in the caller context and update them via tempAt:put:.  But beware
	 ambiguities.  You'd have to parse the bytecode to be sure to get the right temps."
	(numIncrGCs ~= interpreterProxy statIncrGCs
	or: [numFullGCs ~= interpreterProxy statFullGCs]) ifTrue:
		[self error: 'GC occurred in middle of remapOop:in: and remapping in this context is not implemented'].
	^result