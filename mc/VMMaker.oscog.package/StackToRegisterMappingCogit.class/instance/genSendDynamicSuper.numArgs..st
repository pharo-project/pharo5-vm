bytecode generators
genSendDynamicSuper: selector numArgs: numArgs
	self marshallSendArguments: numArgs.
	^self genMarshalledSendDynamicSuper: selector numArgs: numArgs