testing
testBreakCount: breakCount printSends: shouldPrintSends printFrames: shouldPrintFrames printBytecodes: shouldPrintBytecodes
	self initStackPages.
	self loadInitialContext.
	transcript clear.
	quitBlock := [^self close].
	printSends := true & shouldPrintSends. "true & foo allows evaluating printFoo := true in the debugger"
	printFrameAtEachStep := true & shouldPrintFrames.
	printBytecodeAtEachStep := true & shouldPrintBytecodes.
	self ensureDebugAtEachStepBlock.
	self initialEnterSmalltalkExecutive