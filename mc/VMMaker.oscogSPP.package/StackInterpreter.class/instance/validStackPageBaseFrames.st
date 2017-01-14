stack pages
validStackPageBaseFrames
	"Check that the base frames in all in-use stack pages have a sender and a saved context."
	<var: #aPage type: #'StackPage *'>
	0 to: numStackPages - 1 do:
		[:i| | aPage senderContextOrNil savedThisContext |
		aPage := stackPages stackPageAt: i.
		(stackPages isFree: aPage) ifFalse:
			[(self validStackPageBaseFrame: aPage) ifFalse:
				[^false]]].
	^true