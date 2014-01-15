frame access
checkIsStillMarriedContext: aContext currentFP: currentFP
	"Another version of isWidowedContext:currentFP: for debugging.
	 This will not bereave a widowed context."
	| thePage theFP limitFP |
	<inline: false>
	<var: #currentFP type: #'char *'>
	<var: #thePage type: #'StackPage *'>
	<var: #theFP type: #'char *'>
	<var: #limitFP type: #'char *'>
	(objectMemory isIntegerObject: (objectMemory fetchPointer: SenderIndex ofObject: aContext)) ifFalse:
		[^false].
	theFP := self frameOfMarriedContext: aContext.
	thePage := stackPages stackPageFor: theFP.
	limitFP := (thePage = stackPage and: [currentFP notNil])
				ifTrue: [currentFP]
				ifFalse: [thePage headFP].
	^theFP >= limitFP
	   and: [(objectMemory isNonIntegerObject: (self frameCallerFP: theFP) asInteger)
	   and: [(self withSmallIntegerTags: (self frameCallerFP: theFP))
			= (objectMemory fetchPointer: InstructionPointerIndex ofObject: aContext)
	   and: [(self frameMethodObject: theFP)
			= (objectMemory fetchPointer: MethodIndex ofObject: aContext)
	   and: [(self frameHasContext: theFP)
	   and: [(self frameContext: theFP) = aContext
	   and: [objectMemory isContext: aContext]]]]]]