callback support
enterCallback: aCallbackOop method: enterMethod callbackCtx: vmCallbackContextOop
callbackArgs: argsArray
"
similar to #sendInvokeCallbackContext: , except that we don't lookup for method.

"
"	<export: true>
	<var: #vmCallbackContext type: #'VMCallbackContext *'>
"
	<doNotGenerate>
	| primMethod vmCallbackContext |
	primMethod := newMethod.
	newMethod := enterMethod.

	vmCallbackContext := self firstIndexableField: vmCallbackContextOop.
	
	self saveCStackStateForCallbackContext: vmCallbackContext. "restoreCStackStateForCallbackContext:  "

	self push: aCallbackOop.
	self push: argsArray.
	self push: vmCallbackContextOop.	
	self push: primMethod.


	self ifAppropriateCompileToNativeCode: newMethod selector: messageSelector.
	self justActivateNewMethod.
	(self isMachineCodeFrame: framePointer) ifFalse:
		[self maybeFlagMethodAsInterpreted: newMethod].
	self externalWriteBackHeadFramePointers.
	self handleStackOverflow.
	self enterSmalltalkExecutiveFromCallback.
	"not reached"
	^true