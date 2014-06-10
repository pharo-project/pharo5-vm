callback support
reestablishContextPriorToCallback: callbackContext
	"callbackContext is an activation of invokeCallback:stack:registers:jmpbuf:.  Its sender
	is the interpreter's state prior to the callback.  Reestablish that state."
	self notYetImplemented