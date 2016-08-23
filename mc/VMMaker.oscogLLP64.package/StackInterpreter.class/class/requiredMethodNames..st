translation
requiredMethodNames: options
	"return the list of method names that should be retained for export or other support reasons"
	| requiredList |
	requiredList := self exportAPISelectors: options.
	requiredList addAll: (self objectMemoryClass requiredMethodNames: options).
	"A number of methods required by VM support code, jitter, specific platforms etc"
	requiredList addAll: #(
		assertValidExecutionPointe:r:s:
		characterForAscii:
		findClassOfMethod:forReceiver: findSelectorOfMethod:
			forceInterruptCheck forceInterruptCheckFromHeartbeat fullDisplayUpdate
		getCurrentBytecode getFullScreenFlag getInterruptKeycode getInterruptPending
			getSavedWindowSize getThisSessionID
		interpret
		loadInitialContext
		primitiveFail primitiveFailFor: primitiveFlushExternalPrimitives printAllStacks printCallStack printContext:
			printExternalHeadFrame printFramesInPage: printFrame: printHeadFrame printMemory printOop:
				printStackPages printStackPageList printStackPagesInUse printStackPageListInUse
		readableFormat: readImageFromFile:HeapSize:StartingAt:
		setFullScreenFlag: setInterruptKeycode: setInterruptPending: setInterruptCheckChain:
			setSavedWindowSize: success:
		validInstructionPointer:inMethod:framePointer:).

	"Nice to actually have all the primitives available"
	requiredList addAll: (self primitiveTable select: [:each| each isSymbol]).

	"InterpreterProxy is the internal analogue of sqVirtualMachine.c, so make sure to keep all those"
	InterpreterProxy organization categories do:
		[:cat |
		((cat ~= 'initialize') and: [cat ~= 'private']) ifTrue:
			[requiredList addAll: (InterpreterProxy organization listAtCategoryNamed: cat)]].

	^requiredList