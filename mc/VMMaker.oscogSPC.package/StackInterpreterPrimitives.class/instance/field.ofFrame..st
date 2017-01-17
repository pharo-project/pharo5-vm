object access primitives
field: index ofFrame: theFP
	"Arrange to answer naked frame pointers for unmarried
	 senders to avoid reifying contexts in the search."
	<var: #theFP type: #'char *'>
	<inline: false>
	| callerFP |
	<var: #callerFP type: #'char *'>
	^index caseOf:
		{[SenderIndex] ->	[callerFP := self frameCallerFP: theFP.
							 callerFP = 0
								ifTrue: [self frameCallerContext: theFP]
								ifFalse: [(self frameHasContext: callerFP)
											ifTrue: [self assert: (self checkIsStillMarriedContext: (self frameContext: callerFP) currentFP: nil).
													self frameContext: callerFP]
											ifFalse: [callerFP asInteger]]].
		[StackPointerIndex]			->	[ConstZero].
		[InstructionPointerIndex]	->	[ConstZero].
		[MethodIndex]				->	[self frameMethodObject: theFP].
		[ClosureIndex]				->	[(self frameIsBlockActivation: theFP)
											ifTrue: [self frameStackedReceiver: theFP
														numArgs: (self frameNumArgs: theFP)]
											ifFalse: [objectMemory nilObject]].
		[ReceiverIndex]				->	[self frameReceiver: theFP] }
		otherwise:
			[self assert: (index - CtxtTempFrameStart between: 0 and: (self stackPointerIndexForFrame: theFP)).
			 self temporary: index - CtxtTempFrameStart in: theFP]