debug support
assertValidStackedInstructionPointersIn: aStackPage line: ln
	"Check that the stacked instruction pointers in the given page are correct.
	 Checks the interpreter sender/machine code callee contract."
	<var: #aStackPage type: #'StackPage *'>
	<var: #theFP type: #'char *'>
	<var: #callerFP type: #'char *'>
	<var: #theIP type: #usqInt>
	<var: #theMethod type: #'CogMethod *'>
	<inline: false>
	| prevFrameWasCogged theFP callerFP theMethod theIP methodObj |
	(self asserta: (stackPages isFree: aStackPage) not l: ln) ifFalse:
		[^false].
	prevFrameWasCogged := false.
	"The top of stack of an inactive page is always the instructionPointer.
	 The top of stack of the active page may be the instructionPointer if it has been pushed,
	 which is indicated by a 0 instructionPointer."
	(stackPage = aStackPage and: [instructionPointer ~= 0])
		ifTrue:
			[theIP := instructionPointer.
			theFP := framePointer]
		ifFalse:
			[theIP := (stackPages longAt: aStackPage headSP) asUnsignedInteger.
			 theFP := aStackPage headFP.
			 stackPage = aStackPage ifTrue:
				[self assert: framePointer = theFP l: ln]].
	[(self isMachineCodeFrame: theFP)
		ifTrue:
			[theMethod := self mframeHomeMethod: theFP.
			 self assert: (theIP = cogit ceCannotResumePC
						  or: [theIP >= theMethod asUnsignedInteger
							   and: [theIP < (theMethod asUnsignedInteger + theMethod blockSize)]])
					l: ln.
			prevFrameWasCogged := true]
		ifFalse: "assert-check the interpreter frame."
			[methodObj := self iframeMethod: theFP.
			 prevFrameWasCogged ifTrue:
				[self assert: theIP = cogit ceReturnToInterpreterPC l: ln].
			 theIP = cogit ceReturnToInterpreterPC ifTrue:
				[theIP := self iframeSavedIP: theFP].
			 self assert: (theIP >= (methodObj + (objectMemory lastPointerOf: methodObj))
						  and: [theIP < (methodObj + (objectMemory numBytesOfBytes: methodObj) + objectMemory baseHeaderSize - 1)])
				l: ln.
			 prevFrameWasCogged := false].
	 theIP := (stackPages longAt: theFP + FoxCallerSavedIP) asUnsignedInteger.
	 (callerFP := self frameCallerFP: theFP) ~= 0] whileTrue:
		[theFP := callerFP].
	self assert: theIP = cogit ceBaseFrameReturnPC l: ln.
	^true