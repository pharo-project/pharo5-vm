stack pages
validStackPageBaseFrames
	"Check that the base frames in all in-use stack pages have a sender and a saved context."
	<var: #aPage type: #'StackPage *'>
	0 to: numStackPages - 1 do:
		[:i| | aPage senderContextOrNil savedThisContext |
		aPage := stackPages stackPageAt: i.
		(stackPages isFree: aPage) ifFalse:
			[senderContextOrNil := stackPages longAt: aPage baseAddress.
			 savedThisContext := stackPages longAt: aPage baseAddress - BytesPerWord.
			 (self asserta: aPage baseFP + (self frameStackedReceiverOffset: aPage baseFP) + (2 * BytesPerWord) = aPage baseAddress) ifFalse:
				[^false].
			 (self asserta: (objectMemory addressCouldBeObj: senderContextOrNil)) ifFalse:
				[^false].
			 (self asserta: (objectMemory addressCouldBeObj: savedThisContext)) ifFalse:
				[^false].
			 (self asserta: (senderContextOrNil = objectMemory nilObject or: [objectMemory isContext: senderContextOrNil])) ifFalse:
				[^false].
			 (self asserta: (objectMemory isContext: savedThisContext)) ifFalse:
				[^false].
			 (self asserta: (self frameCallerContext: aPage baseFP) = senderContextOrNil) ifFalse:
				[^false].
			 (self asserta: (self frameContext: aPage baseFP) = savedThisContext) ifFalse:
				[^false]]].
	^true