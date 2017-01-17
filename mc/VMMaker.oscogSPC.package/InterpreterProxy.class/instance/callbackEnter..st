callback support
callbackEnter: callbackID
	"Re-enter the interpreter for executing a callback"
	<var: #callbackID type: #'sqInt *'>
	^self notYetImplementedError