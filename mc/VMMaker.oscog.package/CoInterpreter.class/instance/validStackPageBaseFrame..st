stack pages
validStackPageBaseFrame: aPage
	"Check that the base frame in the stack page has a valid sender and saved context."
	<var: #aPage type: #'StackPage *'>
	<inline: false>
	| savedThisContext senderContextOrNil |
	senderContextOrNil := stackPages longAt: aPage baseAddress.
	savedThisContext := stackPages longAt: aPage baseAddress - objectMemory wordSize.
	(self asserta: aPage baseFP + (self frameStackedReceiverOffset: aPage baseFP) + (2 * objectMemory wordSize) = aPage baseAddress) ifFalse:
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
		[^false].
	^true