frame access
isWidowedContextDuringGC: aOnceMarriedContext
	"See if the argument is married to a live frame or not.  i.e. see if there is a matching
	 frame whose frameContext field is aOnceMarriedContext, or a forwarder to it.
	 If aOnceMarriedContext is not married to a live frame, turn it into a bereaved single context.
	 This version is for use during scavenging when stack references may be forwarded.
	 Following what appear to be references to forwarded objects on the stack is dangerous;
	 an instruction ponter may be correctly aligned and may point to bytes that just happen
	 to look like a forwarder. So it is only safe to follow fields that we know are frameContext
	 fields; hence the stack page is walked to check that aOnceMarriedContext is pointing to
	 a live frame.  This only has to happen during scavenging because after a become: all
	 frameContext fields have been followed and so there is no need to follow forwarders."
	| maybeFrame thePage shouldBeFrameCallerField maybeFrameCtxt |
	<var: #maybeFrame type: #'char *'>
	<var: #thePage type: #'StackPage *'>
	<var: #shouldBeFrameCallerField type: #'char *'>
	self assert: ((objectMemory isContext: aOnceMarriedContext)
				  and: [self isMarriedOrWidowedContext: aOnceMarriedContext]).
	maybeFrame := self frameOfMarriedContext: aOnceMarriedContext.
	thePage := stackPages stackPageFor: maybeFrame.
	((stackPages isFree: thePage)
	 or: [maybeFrame < thePage headFP]) ifFalse:
		["The frame pointer is within the bounds of a live page.
		   Now check if it matches a frame."
		 shouldBeFrameCallerField := self withoutSmallIntegerTags:
											(objectMemory
												fetchPointer: InstructionPointerIndex
												ofObject: aOnceMarriedContext).
		 ((self frameCallerFP: maybeFrame) = shouldBeFrameCallerField
		  and: [self frameHasContext: maybeFrame]) ifTrue:
			[maybeFrameCtxt := self frameContext: maybeFrame.
			 "On Spur we need to follow the context to check for a match, but since the VM is
			  only speculating about maybeFrame being a frame, and only speculating about
			  maybeContext being a context, we need to be sure before we can safely follow."
			 (objectMemory hasSpurMemoryManagerAPI
			  and: [(self isFrame: maybeFrame onPage: thePage)
			  and: [objectMemory isForwarded: maybeFrameCtxt]]) ifTrue:
				[maybeFrameCtxt := objectMemory followForwarded: maybeFrameCtxt.
				 self setFrameContext: maybeFrame to: maybeFrameCtxt].
			 maybeFrameCtxt = aOnceMarriedContext ifTrue: "It is still married!"
				[^false]]].
	"It is out of range or doesn't match the frame's context.
	 It is widowed. Time to wear black."
	self markContextAsDead: aOnceMarriedContext.
	^true