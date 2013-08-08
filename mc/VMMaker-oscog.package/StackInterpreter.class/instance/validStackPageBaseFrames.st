stack pages
validStackPageBaseFrames
	"Check that the base frames in all in-use stack pages have a valid sender context."
	<var: #aPage type: #'StackPage *'>
	0 to: numStackPages - 1 do:
		[:i| | aPage senderContextOrNil |
		aPage := stackPages stackPageAt: i.
		(stackPages isFree: aPage) ifFalse:
			[(self asserta: (self isBaseFrame: aPage baseFP)) ifFalse:
				[^false].
			 senderContextOrNil := self frameCallerContext: aPage baseFP.
			 (self asserta: (objectMemory addressCouldBeObj: senderContextOrNil)) ifFalse:
				[^false].
			 (self asserta: (senderContextOrNil = objectMemory nilObject or: [objectMemory isContext: senderContextOrNil])) ifFalse:
				[^false]]].
	^true