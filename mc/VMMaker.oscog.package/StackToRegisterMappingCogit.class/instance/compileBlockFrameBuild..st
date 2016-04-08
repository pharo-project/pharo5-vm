compile abstract instructions
compileBlockFrameBuild: blockStart
	"Build a frame for a block activation.  See CoInterpreter class>>initializeFrameIndices.
	 Override to push the register receiver and register arguments, if any, and to correctly
	 initialize the explicitly nilled/pushed temp entries (they are /not/ of type constant nil)."
	super compileBlockFrameBuild: blockStart.
	methodOrBlockNumTemps := blockStart numArgs + blockStart numCopied + blockStart numInitialNils.
	self initSimStackForFramefulMethod: blockStart startpc.
	blockStart numInitialNils > 0 ifTrue:
		[blockStart numInitialNils > 1
			ifTrue:
				[self genMoveNilR: TempReg.
				 1 to: blockStart numInitialNils do:
					[:ign| self PushR: TempReg]]
			ifFalse:
				[self genPushConstant: objectMemory nilObject].
		 methodOrBlockNumTemps := blockStart numArgs + blockStart numCopied]