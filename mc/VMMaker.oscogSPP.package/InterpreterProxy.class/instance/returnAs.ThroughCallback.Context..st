callback support
returnAs: returnTypeOop ThroughCallback: vmCallbackContext Context: callbackMethodContext
	<returnTypeC: #sqInt>
	<var: #vmCallbackContext type: #'VMCallbackContext *'>
	"callbackMethodContext is an activation of invokeCallback:[stack:registers:jmpbuf:].
	 Its sender is the VM's state prior to the callback.  Reestablish that state (via longjmp),
	 and mark callbackMethodContext as dead."
	self notYetImplemented