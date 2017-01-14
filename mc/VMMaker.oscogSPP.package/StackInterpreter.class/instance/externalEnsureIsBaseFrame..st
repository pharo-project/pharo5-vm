frame access
externalEnsureIsBaseFrame: aFramePtr
	"Ensure aFramePtr is a base frame.  Then we can assign its sender.
	 Answer the possibly moved location of the frame."
	| theFP thePage onCurrent |
	<var: #aFramePtr type: #'char *'>
	<var: #theFP type: #'char *'>
	<var: #thePage type: #'StackPage *'>
	<returnTypeC: 'char *'>
	(self isBaseFrame: aFramePtr) ifTrue:
		[^aFramePtr].
	theFP := aFramePtr.
	thePage := stackPages stackPageFor: theFP.
	onCurrent := thePage = stackPage.
	"Storing the frame's sender with its caller's context
	 has the side effect of making theFP a base frame."
	theFP := self
				storeSenderOfFrame: theFP
				withValue: (self ensureCallerContext: theFP).
	onCurrent
		ifTrue:
			[self assert: stackPage ~~ thePage. "stackPage has moved to a new page"
			 framePointer := stackPage headFP.
			 stackPointer := stackPage headSP]
		ifFalse:
			[stackPages markStackPageMostRecentlyUsed: stackPage].
	self assert: stackPages pageListIsWellFormed.
	self assert: stackPage = stackPages mostRecentlyUsedPage.
	^theFP