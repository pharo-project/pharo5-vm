control primitives
primitiveExecuteMethodArgsArray
	"receiver, argsArray, then method are on top of stack.  Execute method against
	 receiver and args.  Allow for up to two extra arguments (e.g. for mirror primitives).
	 Set primitiveFunctionPointer because no cache lookup has been done for the
	 method, and hence primitiveFunctionPointer is stale."
	| methodArgument argCnt rcvr argumentArray primitiveIndex |
	methodArgument := self stackTop.
	argumentArray := self stackValue: 1.
	((objectMemory isOopCompiledMethod: methodArgument)
	 and: [objectMemory isArray: argumentArray]) ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	argCnt := self argumentCountOf: methodArgument.
	argCnt = (objectMemory numSlotsOf: argumentArray) ifFalse:
		[^self primitiveFailFor: PrimErrBadNumArgs].
	argumentCount > 2 ifTrue: "CompiledMethod class>>receiver:withArguments:executeMethod:
								SqueakObjectPrimitives class>>receiver:withArguments:apply:
								VMMirror>>ifFail:object:with:executeMethod: et al"
		[rcvr := self stackValue: 2.
		 (argumentCount > 4
		  or: [objectMemory isOopForwarded: rcvr]) ifTrue:
			[^self primitiveFailFor: PrimErrUnsupported].
		self stackValue: argumentCount put: rcvr]. "replace actual receiver with desired receiver"
	"and push the actual arguments"
	self pop: argumentCount.
	0 to: argCnt - 1 do:
		[:i|
		self push: (objectMemory fetchPointer: i ofObject: argumentArray)].
	newMethod := methodArgument.
	primitiveIndex := self primitiveIndexOf: newMethod.
	primitiveFunctionPointer := self functionPointerFor: primitiveIndex inClass: nil.
	argumentCount := argCnt.
	self executeNewMethod.
	"Recursive xeq affects primErrorCode"
	self initPrimCall