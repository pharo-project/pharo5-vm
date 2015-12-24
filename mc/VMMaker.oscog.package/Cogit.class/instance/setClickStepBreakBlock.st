simulation only
setClickStepBreakBlock
	"Set the break block to present a confirmer, breaking if true, and restoring the previous break block.
	 If an open debugger on the receiver can be found, proceed it."
	<doNotGenerate>
	| previousBreakBlock previousBreakPC previousSingleStep |
	(breakBlock isNil or: [breakBlock method ~~ thisContext method]) ifTrue:
		[previousBreakBlock := breakBlock.
		 previousBreakPC := breakPC.
		 previousSingleStep := singleStep.
		 breakBlock := [:ign|
						(processor pc ~= previousBreakPC
						 and: [UIManager confirm: 'step?'])
							ifTrue: [false]
							ifFalse: [breakBlock := previousBreakBlock.
									breakPC := previousBreakPC.
									singleStep := previousSingleStep.
									true]].
		 singleStep := breakPC := true].
	(World submorphs
		detect:
			[:m|
			 m model class == Debugger
			 and: [(m model interruptedProcess suspendedContext findContextSuchThat:
					[:ctxt|
					ctxt receiver == self
					and: [ctxt selector == #simulateCogCodeAt:]]) notNil]]
		ifNone: []) ifNotNil:
			[:debuggerWindow|
			 WorldState addDeferredUIMessage:
				[debuggerWindow model proceed]]