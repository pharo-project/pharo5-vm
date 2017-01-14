frame access
frameStackedReceiverOffsetNumArgs: numArgs
	"Answer the offset in bytes from the a frame pointer to its stacked receiver,
	 given the argument count.  The receiver of a message send or the closure of
	 a block activation is always on the stack above any arguments and the frame
	 itself.  See the diagram in StackInterpreter class>>initializeFrameIndices."
	<inline: true>
	^FoxCallerSavedIP + objectMemory wordSize + (numArgs << objectMemory shiftForWord)