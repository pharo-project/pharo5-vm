evaluation
valueWithStackPointer: stackPtr "<Integer>" "^<FFICallbackReturnValue>"
	argsProxy addressFieldPut: stackPtr.
	"Cloning the block to allow reentrant callbacks in Squeak."
	block copy value: argsProxy value: resultProxy.
	^resultProxy