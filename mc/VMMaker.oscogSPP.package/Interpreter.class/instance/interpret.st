interpreter shell
interpret
	"This is the main interpreter loop. It normally loops forever, fetching and executing
	 bytecodes.  When running in the context of a browser plugin VM, however, it must
	 return control to the browser periodically.  This should done only when the state of
	 the currently running Squeak thread is safely stored in the object heap.  Since this
	 is the case at the moment that a check for interrupts is performed, that is when we
	 return to the browser if it is time to do so.  Interrupt checks happen quite frequently."

	<inline: false> "should *not* be inlined into sendInvokeCallback:Stack:Registers:Jmpbuf:"
	"record entry time when running as a browser plug-in"
	self browserPluginInitialiseIfNeeded.
	self internalizeIPandSP.
	self fetchNextBytecode.
	[true] whileTrue: [self dispatchOn: currentBytecode in: BytecodeTable].
	localIP := localIP - 1.  "undo the pre-increment of IP before returning"
	self externalizeIPandSP.
	^nil
