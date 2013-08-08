callback support
sendInvokeCallback: thunkPtr Stack: stackPtr Registers: regsPtr Jmpbuf: jmpBufPtr
	"Override to log and check stack alignment.  Since this is an implicit send we need to
	 log it explicitly. The return side is done via a primitive so that gets logged normally."
	cogit assertCStackWellAligned.
	cogit recordPrimTrace ifTrue:
		[self fastLogPrim: (self splObj: SelectorInvokeCallback)].
	^super sendInvokeCallback: thunkPtr Stack: stackPtr Registers: regsPtr Jmpbuf: jmpBufPtr