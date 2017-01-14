frame access
externalDivorceFrame: theFP andContext: ctxt
	"Divorce a single frame and its context.  If it is not the top frame of a stack this means splitting its stack."
	| thePage onCurrent theSP callerCtx newPage frameAbove callerFP callerSP callerIP theIP |
	<inline: false>
	<var: #theFP type: #'char *'>
	<var: #thePage type: #'StackPage *'>
	<var: #theSP type: #'char *'>
	<var: #newPage type: #'StackPage *'>
	<var: #frameAbove type: #'char *'>
	<var: #callerFP type: #'char *'>
	<var: #callerSP type: #'char *'>
	"stackPage needs to have current head pointers to avoid confusion."
	self assert: (stackPage = 0 or: [stackPage = stackPages mostRecentlyUsedPage]).
	thePage := stackPages stackPageFor: theFP.
	(onCurrent := thePage = stackPage) ifFalse:
		[stackPages markStackPageNextMostRecentlyUsed: thePage].
	theSP := self findSPOf: theFP on: thePage.
	self updateStateOfSpouseContextForFrame: theFP WithSP: theSP.
	callerCtx := self ensureCallerContext: theFP.
	(frameAbove := self findFrameAbove: theFP inPage: thePage) == 0
		ifTrue: "If we're divorcing the top frame we can simply peel it off."
			[theIP := stackPages longAt: thePage headSP]
		ifFalse: "othewise move all frames above to a new stack and then peel the frame off."
			[newPage := stackPages newStackPage.
			 theIP := self oopForPointer: (self frameCallerSavedIP: frameAbove).
			 frameAbove := self moveFramesIn: thePage through: frameAbove toPage: newPage.
			 onCurrent
				ifTrue:
					[self setStackPageAndLimit: newPage.
					 framePointer := stackPage headFP.
					 stackPointer := stackPage headSP]
				ifFalse:
					[stackPages markStackPageMostRecentlyUsed: newPage].
			 self assert: (self frameCallerContext: frameAbove) = ctxt].
	objectMemory storePointerUnchecked: InstructionPointerIndex
		ofObject: ctxt
		withValue: (self contextInstructionPointer: theIP frame: theFP).
	objectMemory storePointer: SenderIndex
		ofObject: ctxt
		withValue: callerCtx.
	callerFP := self frameCallerFP: theFP.
	callerFP == 0 "theFP is a base frame; it is now alone; free the entire page"
		ifTrue: [stackPages freeStackPage: thePage]
		ifFalse:
			[callerIP := self oopForPointer: (self frameCallerSavedIP: theFP).
			 callerSP := (self frameCallerSP: theFP) - objectMemory wordSize.
			 stackPages longAt: callerSP put: callerIP.
			 self setHeadFP: callerFP andSP: callerSP inPage: thePage]
	