frame access
isWidowedContext: aOnceMarriedContext
	"See if the argument is married to a live frame or not.
	 If it is not, turn it into a bereaved single context. This version is safe for use
	 only when no frameContext fields may be forwarded (as maybe the case
	 when scavenging).  Post become: all frameContext fields are followed, and
	 hence nrmally no following of frameCOtext fields is necessary.  But during
	 a scavenge one must use isWidowedContextDuringGC:."
	| theFrame thePage shouldBeFrameCallerField |
	<var: #theFrame type: #'char *'>
	<var: #thePage type: #'StackPage *'>
	<var: #shouldBeFrameCallerField type: #'char *'>
	self assert: ((objectMemory isContext: aOnceMarriedContext)
				  and: [self isMarriedOrWidowedContext: aOnceMarriedContext]).
	theFrame := self frameOfMarriedContext: aOnceMarriedContext.
	thePage := stackPages stackPageFor: theFrame.
	((stackPages isFree: thePage)
	 or: [theFrame < thePage headFP]) ifFalse:
		["The frame pointer is within the bounds of a live page.
		   Now check if it matches a frame."
		 shouldBeFrameCallerField := self withoutSmallIntegerTags:
											(objectMemory
												fetchPointer: InstructionPointerIndex
												ofObject: aOnceMarriedContext).
		 ((self frameCallerFP: theFrame) = shouldBeFrameCallerField
		  and: [self frameHasContext: theFrame]) ifTrue:
			[self deny: (((self isFrame: theFrame onPage: thePage))
						and: [objectMemory isForwarded: (self frameContext: theFrame)]).
			 (self frameContext: theFrame) = aOnceMarriedContext ifTrue: "It is still married!"
				[^false]]].
	"It is out of range or doesn't match the frame's context.
	 It is widowed. Time to wear black."
	self markContextAsDead: aOnceMarriedContext.
	^true