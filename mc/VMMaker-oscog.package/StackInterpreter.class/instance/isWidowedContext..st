frame access
isWidowedContext: aOnceMarriedContext
	"See if the argument is connected with a live frame or not.
	 If it is not, turn it into a bereaved single context."
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
										(objectMemory fetchPointer: InstructionPointerIndex
											ofObject: aOnceMarriedContext).
		 ((self frameCallerFP: theFrame) = shouldBeFrameCallerField
		  and: [(self frameMethodObject: theFrame) = (objectMemory fetchPointer: MethodIndex
													ofObject: aOnceMarriedContext)
		  and: [(self frameHasContext: theFrame)
		  and: [(self frameContext: theFrame) = aOnceMarriedContext]]]) ifTrue:
			["It is still married!"
			^false]].
	"It is out of range or doesn't match the frame's context.
	 It is widowed. Time to wear black."
	self markContextAsDead: aOnceMarriedContext.
	^true