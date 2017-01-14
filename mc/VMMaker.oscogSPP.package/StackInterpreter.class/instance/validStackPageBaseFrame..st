stack pages
validStackPageBaseFrame: aPage
	"Check that the base frame in the stack page has a valid sender context."
	<var: #aPage type: #'StackPage *'>
	<inline: false>
	| senderContextOrNil |
	(self asserta: (self isBaseFrame: aPage baseFP)) ifFalse:
		[^false].
	senderContextOrNil := self frameCallerContext: aPage baseFP.
	(self asserta: (objectMemory addressCouldBeObj: senderContextOrNil)) ifFalse:
		[^false].
	(self asserta: (senderContextOrNil = objectMemory nilObject or: [objectMemory isContext: senderContextOrNil])) ifFalse:
		[^false].
	^true