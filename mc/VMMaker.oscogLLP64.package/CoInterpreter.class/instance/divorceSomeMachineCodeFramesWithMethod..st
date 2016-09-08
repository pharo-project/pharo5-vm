frame access
divorceSomeMachineCodeFramesWithMethod: cogMethod
	"Divorce at most one frame (since the divorce may cause the containing
	 page to be split) and answer whether a frame was divorced."
	<var: #cogMethod type: #'CogMethod *'>
	| divorcedSome |
	<var: #aPage type: #'StackPage *'>
	divorcedSome := false.
	0 to: numStackPages - 1 do:
		[:i| | aPage |
		aPage := stackPages stackPageAt: i.
		(stackPages isFree: aPage) ifFalse:
			["this to avoid assert in externalDivorceFrame:andContext:"
			 stackPages markStackPageMostRecentlyUsed: stackPage.
			 (self divorceAMachineCodeFrameWithCogMethod: cogMethod in: aPage) ifTrue:
				[divorcedSome := true]]].
	^divorcedSome