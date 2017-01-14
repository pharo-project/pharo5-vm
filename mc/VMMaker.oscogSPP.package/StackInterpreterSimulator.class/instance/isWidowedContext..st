frame access
isWidowedContext: aOnceMarriedContext
	"See if the argument is connected with a live frame or not.
	 If it is not, turn it into a bereaved single context."
	(stackPages isFree: stackPage) ifFalse: "in baseReturn the active page has been freed."
		[((stackPages somePageHasHeadFrameFP: framePointer)
		  or: [(stackPages somePageHasHeadFrameFP: localFP)
		  or: [stackPages allPagesFree]]) ifFalse:
			[thisContext sender sender method = (StackInterpreter >> #baseFrameReturn) ifFalse:
				[self halt: 'currentFP may not be written back to stack page']]].
	^super isWidowedContext: aOnceMarriedContext