translation
requiredMethodNames: options
	"return the list of method names that should be retained for export or other support reasons"
	| requiredList |
	requiredList := Set new: 400.
	"A number of methods required by VM support code, jitter, specific platforms etc"
	requiredList addAll: #(fullDisplayUpdate interpret printCallStack printAllStacks printOop: readImageFromFile:HeapSize:StartingAt: success: readableFormat: getCurrentBytecode characterForAscii: findClassOfMethod:forReceiver: findSelectorOfMethod:forReceiver: loadInitialContext nullCompilerHook primitiveFlushExternalPrimitives setCompilerInitialized: getFullScreenFlag getInterruptCheckCounter getInterruptKeycode getInterruptPending getNextWakeupTick getSavedWindowSize setFullScreenFlag: setInterruptCheckCounter: setInterruptKeycode: setInterruptPending: setNextWakeupTick: setSavedWindowSize: forceInterruptCheck getThisSessionID).

	"Nice to actually have all the primitives available"
	requiredList addAll: self primitiveTable.

	"InterpreterProxy is the internal analogue of sqVirtualMachine.c, so make sure to keep all those"
	InterpreterProxy organization categories do: [:cat |
		((cat ~= 'initialize') and: [cat ~= 'private']) ifTrue: [
			requiredList addAll: (InterpreterProxy organization listAtCategoryNamed: cat)]].
	
	^requiredList