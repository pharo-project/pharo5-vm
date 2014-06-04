object access primitives
fieldOrSenderFP: index ofContext: contextObj
	"Arrange to answer naked frame pointers for unmarried
	 senders to avoid reifying contexts in the search."
	<inline: false>
	| tempIndex spouseFP |
	<var: #spouseFP type: #'char *'>
	tempIndex := index - CtxtTempFrameStart.
	(self isStillMarriedContext: contextObj) ifFalse:
		[^tempIndex >= (self fetchStackPointerOf: contextObj)
			ifTrue: [objectMemory nilObject]
			ifFalse: [self fetchPointer: index ofObject: contextObj]].
	spouseFP := self frameOfMarriedContext: contextObj.
	tempIndex >= (self stackPointerIndexForFrame: spouseFP) ifTrue:
		[^objectMemory nilObject].
	^self field: index ofFrame: spouseFP