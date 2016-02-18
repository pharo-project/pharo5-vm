control primitives
primitiveExecuteMethodArgsArray
	"receiver, argsArray, then method are on top of stack.  Execute method against
	 receiver and args.  Allow for up to two extra arguments (e.g. for mirror primitives).
	 Set primitiveFunctionPointer because no cache lookup has been done for the
	 method, and hence primitiveFunctionPointer is stale."
	| methodArgument argCnt argumentArray |
	methodArgument := self stackTop.
	argumentArray := self stackValue: 1.
	((self isOopCompiledMethod: methodArgument)
	 and: [self isArray: argumentArray]) ifFalse:
		[^self primitiveFail].
	argCnt := self argumentCountOf: methodArgument.
	argCnt = (self numSlotsOf: argumentArray) ifFalse:
		[^self primitiveFail].
	argumentCount > 2 ifTrue: "CompiledMethod class>>receiver:withArguments:executeMethod:
								SqueakObjectPrimitives class >> receiver:withArguments:apply:
								VMMirror>>ifFail:object:with:executeMethod: et al"
		[argumentCount > 4 ifTrue:
			[^self primitiveFail].
		self stackValue: argumentCount put: (self stackValue: 2)]. "replace actual receiver with desired receiver"
	"and push the actual arguments"
	self pop: argumentCount.
	0 to: argCnt - 1 do:
		[:i|
		self push: (self fetchPointer: i ofObject: argumentArray)].
	newMethod := methodArgument.
	primitiveIndex := self primitiveIndexOf: newMethod.
	primitiveFunctionPointer := self functionPointerFor: primitiveIndex inClass: nil.
	argumentCount := argCnt.
	"We set the messageSelector for executeMethod below since things
	 like the at cache read messageSelector and so it cannot be left stale."
	messageSelector := self nilObject.
	self executeNewMethod.
	"Recursive xeq affects successFlag"
	successFlag := true