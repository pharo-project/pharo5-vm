interpreter shell
interpret
	"This is the main interpreter loop. It normally loops forever, fetching and executing bytecodes.
	 When running in the context of a web browser plugin VM, however, it must return control to the
	 web browser periodically. This should done only when the state of the currently running Squeak
	 thread is safely stored in the object heap. Since this is the case at the moment that a check for
	 interrupts is performed, that is when we return to the browser if it is time to do so.  Interrupt
	 checks happen quite frequently.

	Override for simulation to insert bytecode breakpoint support."

	<inline: false>
	"If stacklimit is zero then the stack pages have not been initialized."
	stackLimit = 0 ifTrue:
		[^self initStackPagesAndInterpret].
	"record entry time when running as a browser plug-in"
	self browserPluginInitialiseIfNeeded.
	self internalizeIPandSP.
	self fetchNextBytecode.
	self initExtensions.
	[true] whileTrue:
		[self assertValidExecutionPointers.
		 atEachStepBlock value. "N.B. may be nil"
		 self dispatchOn: currentBytecode in: BytecodeTable.
		 self incrementByteCount].
	localIP := localIP - 1.  "undo the pre-increment of IP before returning"
	self externalizeIPandSP.
	^nil
