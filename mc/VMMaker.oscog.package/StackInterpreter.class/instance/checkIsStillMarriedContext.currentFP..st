frame access
checkIsStillMarriedContext: aContext currentFP: currentFP
	"Another version of isWidowedContext: for debugging.
	 This will not bereave a widowed context."
	| thePage theFP limitFP frameCtxt |
	<inline: false>
	<var: #currentFP type: #'char *'>
	<var: #thePage type: #'StackPage *'>
	<var: #theFP type: #'char *'>
	<var: #limitFP type: #'char *'>
	((objectMemory isContext: aContext)
	 and: [self isMarriedOrWidowedContext: aContext]) ifFalse:
		[^false].
	theFP := self frameOfMarriedContext: aContext.
	thePage := stackPages stackPageFor: theFP.
	limitFP := (thePage = stackPage and: [currentFP notNil])
				ifTrue: [currentFP]
				ifFalse: [thePage headFP].
	(theFP >= limitFP
	 and: [(objectMemory isNonImmediate: (self frameCallerFP: theFP) asInteger)
	 and: [(self withSmallIntegerTags: (self frameCallerFP: theFP))
			= (objectMemory fetchPointer: InstructionPointerIndex ofObject: aContext)
	 and: [self frameHasContext: theFP]]]) ifFalse:
		[^false].
	frameCtxt := self frameContext: theFP.
	(objectMemory isForwarded: frameCtxt) ifTrue:
		[frameCtxt := objectMemory followForwarded: frameCtxt].
	^frameCtxt = aContext