frame access
checkIsStillMarriedContext: aContext currentFP: currentFP
	"Another version of isWidowedContext: for debugging.
	 This will not bereave a widowed context."
	| thePage maybeFP limitFP maybeFrameCtxt |
	<inline: false>
	<var: #currentFP type: #'char *'>
	<var: #thePage type: #'StackPage *'>
	<var: #maybeFP type: #'char *'>
	<var: #limitFP type: #'char *'>
	((objectMemory isContext: aContext)
	 and: [self isMarriedOrWidowedContext: aContext]) ifFalse:
		[^false].
	maybeFP := self frameOfMarriedContext: aContext.
	thePage := stackPages stackPageFor: maybeFP.
	limitFP := (thePage = stackPage and: [currentFP notNil])
				ifTrue: [currentFP]
				ifFalse: [thePage headFP].
	(maybeFP >= limitFP
	 and: [(objectMemory isNonImmediate: (self frameCallerFP: maybeFP) asInteger)
	 and: [(self withSmallIntegerTags: (self frameCallerFP: maybeFP))
			= (objectMemory fetchPointer: InstructionPointerIndex ofObject: aContext)
	 and: [self frameHasContext: maybeFP]]]) ifFalse:
		[^false].
	maybeFrameCtxt := self frameContext: maybeFP.
	"On Spur we need to follow the context to check for a match, but since the VM is
	 only speculating about maybeFrame being a frame, and only speculating about
	 maybeContext being a context, we need to be sure before we can safely follow."
	(objectMemory hasSpurMemoryManagerAPI
	 and: [(stackPages isFree: thePage) not
	 and: [(self isFrame: maybeFP onPage: thePage)
	 and: [objectMemory isForwarded: maybeFrameCtxt]]]) ifTrue:
		[maybeFrameCtxt := objectMemory followForwarded: maybeFrameCtxt].
	^maybeFrameCtxt = aContext