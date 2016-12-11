frame access
frameLastArgumentOffset
	"Answer the offset in bytes from the frame pointer to the last argument,
	 which is simply the address of the word above the saved ip.  See the
	 diagram in StackInterpreter class>>initializeFrameIndices."
	<inline: true>
	^FoxCallerSavedIP + objectMemory wordSize