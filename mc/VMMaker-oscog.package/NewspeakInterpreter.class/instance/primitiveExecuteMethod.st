control primitives
primitiveExecuteMethod
	"receiver, args, then method are on top of stack. Execute method against receiver and args.
	 Set primitiveFunctionPointer because no cache lookup has been done for the method, and
	 hence primitiveFunctionPointer is stale."
	| methodArgument primitiveIndex |
	methodArgument := self stackTop.
	(self isOopCompiledMethod: methodArgument) ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	argumentCount - 1 = (self argumentCountOf: methodArgument) ifFalse:
		[^self primitiveFailFor: PrimErrBadNumArgs].
	newMethod := self popStack.
	primitiveIndex := self primitiveIndexOf: newMethod.
	primitiveFunctionPointer := self functionPointerFor: primitiveIndex inClass: nil.
	argumentCount := argumentCount - 1.
	"We set the messageSelector for executeMethod below since things
	 like the at cache read messageSelector and so it cannot be left stale."
	messageSelector := self nilObject.
	self executeNewMethod.
	"Recursive xeq affects primErrorCode"
	self initPrimCall