frame access
storeSenderOfFrame: theFP withValue: anOop
	"Set the sender of a frame.  If the frame is a base frame then this is trivial;
	 merely store into the FoxCallerSavedIP/FoxCallerContext field.  If not, then
	 split the stack at the frame, moving the frame and those hotter than it to a
	 new stack page.  In the new stack page the frame will be the base frame
	 and storing trivial.  Answer the possibly changed location of theFP."
	| thePage onCurrentPage newPage theMovedFP |
	<var: #theFP type: #'char *'>
	<var: #thePage type: #'StackPage *'>
	<var: #newPage type: #'StackPage *'>
	<var: #theMovedFP type: #'char *'>
	<returnTypeC: #'char *'>
	(self isBaseFrame: theFP) ifTrue:
		[self frameCallerContext: theFP put: anOop.
		 ^theFP].
	self ensureCallerContext: theFP.
	thePage := stackPages stackPageFor: theFP.
	self assert: stackPage = stackPages mostRecentlyUsedPage.
	onCurrentPage := thePage = stackPage.
	onCurrentPage ifFalse:
		["Make sure the frame's page isn't divorced when a new page is allocated."
		 stackPages markStackPageNextMostRecentlyUsed: thePage].
	newPage := stackPages newStackPage.
	theMovedFP := self moveFramesIn: thePage through: theFP toPage: newPage.
	onCurrentPage
		ifTrue: [self setStackPageAndLimit: newPage]
		ifFalse: [stackPages markStackPageMostRecentlyUsed: newPage].
	self assert: (self isBaseFrame: theMovedFP).
	self frameCallerContext: theMovedFP put: anOop.
	^theMovedFP