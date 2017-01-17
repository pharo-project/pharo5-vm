vm scheduling
inGUIThread
	"The first thread is assumed to be the GUI thread, the VM thread that expects to receive
	 window events, etc.  This might appear to invite race conditions but it is only to be used
	 to decide whether to not give up the VM from the GUI thread (see disownVM:)."
	self assert: noThreadingOfGUIThread.
	^cogThreadManager getVMOwner = 1