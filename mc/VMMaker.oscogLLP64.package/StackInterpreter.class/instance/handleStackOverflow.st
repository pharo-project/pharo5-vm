message sending
handleStackOverflow
	"Check for stack overflow, moving frames to another stack if so."
	| newPage theFP callerFP overflowLimitAddress overflowCount |
	<var: #newPage type: #'StackPage *'>
	<var: #theFP type: #'char *'>
	<var: #callerFP type: #'char *'>
	<var: #overflowLimitAddress type: #'char *'>

	"After checkForInterrupts another event check may have been forced, setting both
	 stackLimit and stackPage stackLimit to all ones.  So here we must check against
	 the real stackLimit, not the effective stackLimit."
	stackPointer < stackPage realStackLimit ifFalse:
		[^self].

	self maybeTraceStackOverflow.
	statStackOverflow := statStackOverflow + 1.

	"The stack has overflowed this page.  If the system is executing some recursive algorithm,
	 e.g. fibonacci, then the system could thrash overflowing the stack if the call soon returns
	 back to the current page.  To avoid thrashing, since overflow is quite slow, we can move
	 more than one frame.  The idea is to record which page has overflowed, and the first
	 time it overflows move one frame, the second time two frames, and so on.  We move no
	 more frames than would leave the page half occupied."
	theFP := framePointer.
	stackPage = overflowedPage
		ifTrue:
			[overflowLimitAddress := stackPage baseAddress - stackPages overflowLimit.
			 overflowCount := extraFramesToMoveOnOverflow := extraFramesToMoveOnOverflow + 1.
			 [(overflowCount := overflowCount - 1) >= 0
			   and: [(callerFP := self frameCallerFP: theFP) < overflowLimitAddress
			   and: [(self isBaseFrame: callerFP) not]]] whileTrue:
				[theFP := callerFP]]
		ifFalse:
			[overflowedPage := stackPage.
			 extraFramesToMoveOnOverflow := 0].

	self ensureCallerContext: theFP.
	newPage := stackPages newStackPage.
	self moveFramesIn: stackPage through: theFP toPage: newPage.
	self setStackPageAndLimit: newPage.
	framePointer := stackPage headFP.
	stackPointer := stackPage headSP.
	self isCog
		ifFalse: "To overflow the stack this must be a new frame, but in Cog base frames are married."
			[self assert: (self frameHasContext: framePointer) not.
			 self assert: (self validInstructionPointer: instructionPointer + 1
							inMethod: method
							framePointer: framePointer)]
		ifTrue:
			[self assert: (self validInstructionPointer: instructionPointer + 1
							inFrame: framePointer).
			 self assert: ((self frameHasContext: framePointer) not
						or: [objectMemory isContext: (self frameContext: framePointer)])]