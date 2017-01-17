callback support
sendInvokeCallbackContext: vmCallbackContext
	"Override to add sanity assertions."
	self assertSaneThreadAndProcess.
	^super sendInvokeCallbackContext: vmCallbackContext